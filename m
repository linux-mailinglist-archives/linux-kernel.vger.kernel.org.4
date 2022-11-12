Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65F66269E8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiKLOXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLOXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:23:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F7CE0A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 06:23:39 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 4so6488542pli.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 06:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9AaCZ8WAfpjeSDQ7STKLSNV9+Kr6/3hjw3GaFvuUHO4=;
        b=w+EQNfOU9HvsctHMxKfjHvI6LHdBV+tXm3jN/4uj+p7uD59lDpfryM+Xs11aiD5uip
         4FkecEfcnWf2m/0QzgI05iqydkRLfZhU72lgKlW7fXNt4ZGg9DZ6Anaa1FvodTNwbzPg
         p297axSGKmM5lYQvMCmjaPhROs+IGp/WT4/Ls/ZP0ETAiiW4ApKmEjsgjg4JQ9h/GNP4
         3XtyjXZQ0V+DMQ3BP+OkLbjZxxePgTFGb8kdbSAWAWlY59+1WhoP+k887Xy4T9ET0sqN
         Dz6Whq16emyyXY+FVFz16u6BG+KMo4nq6RSLSsTn6Cruio/gtqKsess+0G519p1S+cjV
         8izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AaCZ8WAfpjeSDQ7STKLSNV9+Kr6/3hjw3GaFvuUHO4=;
        b=dw6inSxlfte4/8gIU5Jrva/skW18dYBbzbI4nJNfBGOizeYm8BHGRLN66cx1Vk65qe
         fYbFZJ0sEwotVhkWeprsjStAnAZ2aq9JmkdPvoiuxTHiDDHxtMHMkw5JUGX+YpTyMhbO
         OeBIlFAY15sCwsfEqrX/tzsSTMuyQqF1IObgglZO5MobEPOV0gvECjlenG9XmVSF/1OE
         0L0KIbulDLYp6k6+xGf6vO14InNRVRwFKCopxrgn01ddIIoAO26EOBtNNttGO/r1lETW
         1klRQ+b34/1XYPEeFkxBbBJmOr/qWMXqO/Fb3jHQzTe9W2CJhLxhwQpALZJQeByyXvGc
         QxIg==
X-Gm-Message-State: ANoB5pnjE3PoCUhyxeEhlqdFA+/4zkDko68D2DVkp8390lt3Yx1dH68A
        7RS5m2EP7VLKt6E6IisgAkyXTw==
X-Google-Smtp-Source: AA0mqf7Of4uNO9Zacj/tIazdwCiwUWGFkPYUXSHNE53CmPX12vcNQJGoCT8F+yXOQVOlrPeOP1xXHA==
X-Received: by 2002:a17:902:c142:b0:188:55f5:972f with SMTP id 2-20020a170902c14200b0018855f5972fmr6969764plj.148.1668263019381;
        Sat, 12 Nov 2022 06:23:39 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:54c6])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b00185402cfedesm3681172plm.246.2022.11.12.06.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 06:23:38 -0800 (PST)
Date:   Sat, 12 Nov 2022 09:23:41 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] mm: vmscan: fix extreme overreclaim and swap floods
Message-ID: <Y2+sbbirX11Vo+XM@cmpxchg.org>
References: <20220802162811.39216-1-hannes@cmpxchg.org>
 <17f04d65-020e-a52d-41e8-0d540e32b475@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f04d65-020e-a52d-41e8-0d540e32b475@loongson.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 02:12:17PM +0800, Hongchen Zhang wrote:
> On 2022/8/3 am 12:28, Johannes Weiner wrote:
> > @@ -2988,8 +2988,6 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
> >   		nr_scanned = targets[lru] - nr[lru];
> >   		nr[lru] = targets[lru] * (100 - percentage) / 100;
> >   		nr[lru] -= min(nr[lru], nr_scanned);
> We should not just remove the following line because kswapd may also call
> this function and there is no side effect to do scan adjust for kswapd,so it
> may be better to change like this:
> +    if (current_is_kswapd())
> 		scan_adjusted = true;
> > -
> > -		scan_adjusted = true

There is no scan_adjusted after this patch.

If you're saying that kswapd should set proportional_reclaim
unconditionally, then no, it should not. Proportional reclaim is not
safe at lower priority levels, as the changelog outlines in detail.
