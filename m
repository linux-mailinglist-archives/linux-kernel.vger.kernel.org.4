Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1823618D6E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKDBHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 21:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDBH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:07:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A616359
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 18:07:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id g24so3545420plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 18:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6YrKFLF99vKf+vuAFydIZNHLPDyAfnsncZ/m3epvQY=;
        b=cboRaK3WpuBT+5LY9UVNwuD+mhWGIZfmX3RXel37wrzF2jAz05GGm7IzeqmEgWaciE
         QCZx1GXgkTnjFa1iZmVBodNdDERP6Y9mXExydB4FcZbCdNs79ECWN2JOI05z0oDnD6IG
         Te+A7cyqj/79UZfF7pBLvvQwinDhQuECULrJ8wFpoeZORRfwZslwDhmezzJ5koWk2Zl3
         HGu55YS9Vb/iE0fYOW2TisPTzwGi+/xuIbKApI+B0yAYfAAWmIieBX0PwqUpWEOk/WBr
         6pxT7XizJMZ/vgGIBcsas2uQ5pUvcklAxHR95gLyfxBY32goa4bUmzSdHNe+uvbMfKY8
         8S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6YrKFLF99vKf+vuAFydIZNHLPDyAfnsncZ/m3epvQY=;
        b=aJEP7EYqWmW3uKXqGt2MUqC3e98NOBgqGzZYfJBu1az7rHapq+3GucSRouQa0lo0T7
         WV3C1o5jbPYO2lsLn8L/5L4M0X3PwJD22HrTkEYdmaCGQ/iXV35Mz8Bemm2vup66jjUz
         GslTDiqi0zkmwQQMhLNBdFG0axFyqJtT7axcsNUdhiPIsKvOEo2o2oFKMH45ln4N3AY3
         vBL6Tc7ERqSLmuuZuzMbKYVeMofP3fWc70JAQU3qz9F0kdz2lLPZhxnFPsEyh+WHjaZ/
         ZHYUaztECnTkeXOta2dPX84Be6ZJ8xHUlGVN5AThozGygHtiXXCub0gGgy5XmpFj7I+j
         mKVw==
X-Gm-Message-State: ACrzQf3KCWguNrrfTH87yj7VIyVx7w/cRRyovQbb/qxYaDQdqNJabwkE
        P/52gHVeBTqe5qSYRtcg7evo8A==
X-Google-Smtp-Source: AMsMyM6A3KjJKLfYuannJa1r8yZ10aNtRA3wvYAn9iUl2+dJF1eoE1nNu6EPt8/5lr2KpUa0YguFcQ==
X-Received: by 2002:a17:902:e548:b0:186:f0d5:1ac2 with SMTP id n8-20020a170902e54800b00186f0d51ac2mr16246049plf.144.1667524044191;
        Thu, 03 Nov 2022 18:07:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:2844:b0ec:e556:30d8])
        by smtp.gmail.com with ESMTPSA id pj14-20020a17090b4f4e00b0020b21019086sm8639999pjb.3.2022.11.03.18.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 18:07:23 -0700 (PDT)
Date:   Thu, 3 Nov 2022 18:07:18 -0700
From:   Peter Collingbourne <pcc@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
Message-ID: <Y2RlxvPAvzVXtw9t@google.com>
References: <20221019202843.40810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019202843.40810-1-helgaas@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 03:28:43PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> as lore.kernel.org because they use different styles, add advertising, and
> may disappear in the future.  The lore archives are more consistent and
> more likely to stick around, so prefer https://lore.kernel.org URLs when
> they exist.

If the commit message contains a line like:

Cc: linux-arm-kernel@lists.infradead.org

this patch causes checkpatch.pl to complain. Would it be possible to
restrict this to URLs?

Peter
