Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2EA63B230
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiK1TZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiK1TZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:25:10 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEE3B94
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:25:09 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id c14so4122440qvq.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zvlGneR6kzy7LLRum6bYtymNr7LK9Ap/NO8h/mpmn5A=;
        b=N1AywFe8X4kol9Wjs+TbFySd5wbHHGBg0dGNKuGpzBnHF8k2xMmIFpg2tieNI/BuLE
         WAMIAdUej/+4aWMY8/ahUnc4KD2kbckh2VBSYInQspSBhZ6MIRztkTVMEbHz36I2cqvS
         MC7siKZRMFw/RxUU9qeftLwiNg7buWzSCPzApq6aqrZigQDeXRLUofPOr6O99o/K9kZh
         vBxEyp7TlT+cDzPmUsCLchecZmm7SY3UKwS+QU/sveTD4Zi9uUIisfNTdQJJsTtUAs8w
         /MKH1qVOYUaML9FZ3H1donWEHlIzp3G5fb2g6zZlBmKs/pUfqmAD9TZBciBxMW08r9X0
         jL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvlGneR6kzy7LLRum6bYtymNr7LK9Ap/NO8h/mpmn5A=;
        b=ZEQbhCJVytQE+1gbjzLj1eBhRCC5stXoUoK8mBDm2vXyjzmqycWismFRLbjfbFplZD
         S7Mdl+UO8bXTSoObSYt8SbAmFRNOAX0nGYDEMcEfelUpqO2LvUE7I1qZQ04q8SKFMTmK
         98YwGFeq9HBUA8mmdGcUZobFcq2CzY8uZjhurvMJ0eQgUZ/F4Zn8QblBIMvfvxSgVR56
         SvbWpxS1BRIxWILw+Pfj5IyOJQH2gjUNBw0/nPiGMmSVh0H+qQdLvf+7V3s/vwSHz5gf
         /tWBWOFWFBf1EJMJkiBQce8UHnqgs6IM+FvI4A8Ugfvvk/SrTjWlY0u8voP1IGMfB4eZ
         y0qg==
X-Gm-Message-State: ANoB5pnrEo/9PbM+pBTQGZc0i6jvwPuTU8JFmwOE12M9VDEv6REYArdg
        GQCeiw4TkGx9xsE9cWJCOzNESA==
X-Google-Smtp-Source: AA0mqf4HeEZ298blJ9FGizPTK79ASHDzBVPa7vr9+/D9RtruYFStFQGWUuBeOdsR15jOaT4JTwYzjw==
X-Received: by 2002:ad4:57ca:0:b0:4bb:6354:8cbb with SMTP id y10-20020ad457ca000000b004bb63548cbbmr48371421qvx.91.1669663508268;
        Mon, 28 Nov 2022 11:25:08 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id r139-20020a37a891000000b006e42a8e9f9bsm8832544qke.121.2022.11.28.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:25:07 -0800 (PST)
Date:   Mon, 28 Nov 2022 14:25:06 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v7 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y4ULEjoXC50I7Ty8@cmpxchg.org>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
 <20221128191616.1261026-5-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128191616.1261026-5-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:16:13AM -0800, Nhat Pham wrote:
> This helps determines the coldest zspages as candidates for writeback.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
