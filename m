Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A0F6CCA40
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjC1Su2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC1Su0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:50:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDB0213B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:50:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id er13so12692208edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680029423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZSVb7anGXXb5zwCrWYt7xgUpKRegbsbYrM5HxY90BU=;
        b=1QR4XjLLHLwM3Zmsgaw3zWAa78I3csLORy/e4VsQEXzXCtITlQVpm9CWPmkA6lEcIE
         l9vmq5KaRQWWkY58REzTUL7Y/u5ZvmJs1xya/EdeYG29I/YbohF5pbuCFsfRBDGYlfpa
         p4+KCJ7vkwLoJ30cObjArAxVzTagZEWVhWKhny11ej+ktXnisgks1Ea5bw54UXSAFUJP
         EZNJCkG8Zn+gP472ONOhnUlgPe0T6dvbJ34PIKUqkH13xcjMBzi1bU5dV74ngPS+pWrQ
         xUZz6BK/4anNdLHeDCltA0sRYmjomO3FLH8/SVTCua/HLKFTspSzgbYC2LJ0qTlNrcOp
         Y5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680029423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZSVb7anGXXb5zwCrWYt7xgUpKRegbsbYrM5HxY90BU=;
        b=VvgJIuMXd/vrO+YIQS5ZVHWXaqjws4vIK90tSNnSq78mOStK+VuBR+R8nKNxPDTj6g
         95SFUJ+zbMXVrKl8n8EhoJt2vpdlfBbHxO1aecIW4zNVVIVFV4LXM8RcYg2KcJw2qWaN
         qvSgCy3inpYPXzjj1YXH+5/xrupijNILuUuQ5q4/cYnqbZluIC1noNIHtiuPsRMpiSAt
         AAmuIQrudXjPqUce5mIDl6jYHjtueF9reWwmDUd7kgViVRwvmstCW4Wd4M9muvjFgSiW
         hvCcjsVVQ10JWNNzhyRJi3zL8Vtd6YQRilb4YIi7yj2cGLgoQf5g8OOJFdItFoXh75ER
         /4eQ==
X-Gm-Message-State: AAQBX9ftdqdcGXJdARBJWsWGiA9kecmFGtwCydy+r058tnCaaZli9BVb
        WNokAOdSwbo44gbcASuGdo1dWw==
X-Google-Smtp-Source: AKy350YqMLxfTGiBnlGBlam96cEvk7E1kr7TovxbqhmiDlCO1BHyJq1gMHGtAsqa2MLi2frxb39ujQ==
X-Received: by 2002:a17:906:3590:b0:8b1:75a0:e5c6 with SMTP id o16-20020a170906359000b008b175a0e5c6mr17691817ejb.18.1680029423006;
        Tue, 28 Mar 2023 11:50:23 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063c1900b008e8e975e185sm15495056ejg.32.2023.03.28.11.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:50:22 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:50:21 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 9/9] memcg: do not modify rstat tree for zero updates
Message-ID: <ZCM27V3Z/Z9TD2zL@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-10-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061638.203420-10-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:38AM +0000, Yosry Ahmed wrote:
> In some situations, we may end up calling memcg_rstat_updated() with a
> value of 0, which means the stat was not actually updated. An example is
> if we fail to reclaim any pages in shrink_folio_list().
> 
> Do not add the cgroup to the rstat updated tree in this case, to avoid
> unnecessarily flushing it.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
