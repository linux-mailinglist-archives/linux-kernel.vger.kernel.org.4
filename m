Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B9E63E566
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiK3XZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiK3XZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:25:23 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53804BF91A;
        Wed, 30 Nov 2022 15:17:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso3529960pjt.0;
        Wed, 30 Nov 2022 15:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OI4oe9f9CJ36Kp9mJv1gCGk1ojeGZwXUPKDrYbhDj4k=;
        b=UVR8LpN1aCq4PBkeoinaOtXdDTMRH+RSulkUIjjbH1VEtqx3WlY0N816NC3l4XGdZQ
         deZFVpTfMZloq63bb+cMsor+078WnOOAMg+4Itrf0bXUcRVjr8cARcdbIE0AE6QRNdqm
         AJvR/abVLCwjQmu76DuT+7lT88knfBiSMu+g1xqzXcA6OIeYnBjWoSRP7udLz2nMlXuA
         bAmJkuhfkutXKRLaJYDhvzYcwvWscu48qjRT1h/GPSBW5OlDs38VPv79RkAOF5u+Q36q
         /YHHkNTUnG7HZfpaqHumPFTCGNSeLZSlYrKYSzflbmfqojCWPRN+a4Lg+WrbO7n3oLRs
         tbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OI4oe9f9CJ36Kp9mJv1gCGk1ojeGZwXUPKDrYbhDj4k=;
        b=YeKfRVrZ+2t7Md7+84NhwSnXAUhvCki7OPHeHz3GvVKRWwhrS7ffFv7IcS6zUQP0+4
         Xnx261iLnbNelx+35QMndCa6Zojjyv1nIfrA8h9zZqjh8s6ZBhT4vfA4hHw4QC4aIE+e
         vmb6sUa8Yfl2XZEDOGAVLgxwPkH+k1rJJ7fAiylsh889AIbPY2YOeGjp9wjkfyZAZNuL
         G0+B50CfU/1Y88LgSs9oB69VehnamHrQwxz0u7jBJVtLgySOzDIxyYEGcvaYjd1XDfgD
         Ks+/D6kqFfZ45rcA7wqRIlJOnqDWi1bT97ddyPkYYwbUKrqXUyJlEGBFb26RmUrU18Cp
         tsog==
X-Gm-Message-State: ANoB5pnYW/OQIw92f0v/0Zcz6kziUTpZnCAwcqkvSGCbGRstUGf1XZu0
        jUQZ/9O9uwENJNvoSDxHPyQOlDN9R5E=
X-Google-Smtp-Source: AA0mqf5bQhX1KOZl7ZuLYypPGnOmCEf/iMe9H+mgCFFH7lLQUvqJXOKgfns+n8I09yS1nrd9RZ5HBA==
X-Received: by 2002:a17:90a:bd11:b0:206:64cd:4797 with SMTP id y17-20020a17090abd1100b0020664cd4797mr67221140pjr.103.1669850171343;
        Wed, 30 Nov 2022 15:16:11 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:360e:7e9f:b234:c094])
        by smtp.gmail.com with ESMTPSA id f23-20020aa79697000000b005742ee3bf71sm1905211pfk.20.2022.11.30.15.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 15:16:10 -0800 (PST)
Date:   Wed, 30 Nov 2022 15:16:07 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Miloslav Trmac <mitr@volny.cz>, linux-input@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH] input/misc: wistron_btns: disable on UML
Message-ID: <Y4fkNy9URvaW+AtN@google.com>
References: <20221130161604.1879-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130161604.1879-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 08:16:04AM -0800, Randy Dunlap wrote:
> The wistron_btns driver calls rtc_cmos_read(), which isn't
> available with UML builds, so disable this driver on UML.
> 
> Prevents this build error:
> 
> ld: drivers/input/misc/wistron_btns.o: in function `poll_bios':
> wistron_btns.c:(.text+0x4be): undefined reference to `rtc_cmos_read'
> 
> Fixes: 0bbadafdc49d ("um: allow disabling NO_IOMEM") # v5.14+
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Miloslav Trmac <mitr@volny.cz>
> Cc: linux-input@vger.kernel.org
> Cc: linux-um@lists.infradead.org

Applied, thank you.

-- 
Dmitry
