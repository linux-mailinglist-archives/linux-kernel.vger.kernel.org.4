Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5631630F92
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiKSQpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiKSQpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:45:04 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50AEB3C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:44:58 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h24so4989761qta.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVxXHX6sEP5LL4WpQCH617uW+GSWgkHDMGXayppXj7A=;
        b=I6Uo+hNYe6FxwUutv2OvMJmmfljPzhufle+JcxlyzcR+jRz6t8ZbziihAkj9aKcGEI
         j5C/YIzMP/E7sPB9LN1kf0P1WBGQaFT5W1zDR1S5CN4/OXnipT0xcmgz2d9ZfHzyvtNE
         jT+RjdcPOpm4I0H/rmdFFtcS1fMImEv1DMh+Q6pLNWiNRU90OuIL/wBoxU39ULQvisfw
         Xgq9+sNXazseBsbcFQMdsfYyPTZe9ZSfwXdYQoE7APW3TCMJYFJdvAeNlLUaenAtPQJk
         42s0NGEsOnsTjF2BpBuvWJd8vMtcCOZbtoq6jD3VGZtcnmyUNDhEDNC2okhzcKFShjbS
         AFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVxXHX6sEP5LL4WpQCH617uW+GSWgkHDMGXayppXj7A=;
        b=eT02CklG1OfJbR4dzoPD0YctH5/nV7+vX3XBKxsP+3AUi2TI6FpgV1vYGF6tPP5gh/
         8IH3n39Ro4IMTb09jTB86ObSgtbP3J2EFQPm0Ml97kwc80czHVCF/Sc0fGiSCvn73ZaU
         fLTkFImkXgCgLe0VTYvnnu14L7DTOWrgPAW4+kvYeVw6oQyLrtlV1FGZVmjcMXpSHZVV
         4cuYW4MazsXlm/wVMaqserK9niDvlvGffTMCuNHMmdMX3udM2ITAUEa8oQUK1JhRRhoX
         8+9uDO3SG+34dXMjkbirlbrih8ObD2ammFx5Xa7fnUjplTqcmNDGKpxPxBCZE7HZV2IE
         vZNA==
X-Gm-Message-State: ANoB5pnWR235oK6ReEWgurkbCwSKh+WgOsxnTIurxXulZb3UASY8h2c5
        YAMMCytpTt7zxEvQ1nuFgvMXzw==
X-Google-Smtp-Source: AA0mqf7ST/JZ64atnlAaGs5/EFIKEXRjD9YUT1i0q67CmAZtX7u/tZbIOconBx42BJKZGkmvMk6Fqg==
X-Received: by 2002:ac8:67d0:0:b0:399:acab:ed6d with SMTP id r16-20020ac867d0000000b00399acabed6dmr11491133qtp.101.1668876297752;
        Sat, 19 Nov 2022 08:44:57 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id bs10-20020ac86f0a000000b003992448029esm3974015qtb.19.2022.11.19.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 08:44:57 -0800 (PST)
Date:   Sat, 19 Nov 2022 11:45:21 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3kIIRKt8ORaYFRf@cmpxchg.org>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-7-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 04:15:36PM -0800, Nhat Pham wrote:
> This commit adds the writeback mechanism for zsmalloc, analogous to the
> zbud allocator. Zsmalloc will attempt to determine the coldest zspage
> (i.e least recently used) in the pool, and attempt to write back all the
> stored compressed objects via the pool's evict handler.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Excellent!
