Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE0F6AA40C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjCCWS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjCCWSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:18:13 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381B364850
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 14:09:01 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id y11so4280087plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 14:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677881226;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vT4hCln+8AUzjma0yQmnpAKI/3bKxubNTph4cCGtpoI=;
        b=ogFgXxz00FIm6asu3dQlANu8RUWyqwvJL/9nUc1w2tCnzF0esKKSbodptm44l97lZq
         CgCURXaWpFFaNXXQmMoHY6rBe3bLBgus2xx7kRyDw0yly1WdS2VPuPlRJzHWvw4mmYBK
         eGFQCQvaWkIekkhrT0HGCcBLURGHON/fVImAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677881226;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vT4hCln+8AUzjma0yQmnpAKI/3bKxubNTph4cCGtpoI=;
        b=7QLVSw9/LPw/GAaNFw7+WR3yYnNxFR+72HeP9si9517DbY9AMnrz1cTi+MQAOOtP3V
         oQ60LapzJU9roE8DHZLzcExIVStjulFUwcx9r+nmEr5hnkRmrrb2W1OhbFwbW5vB9IjB
         u1idMZbE+wPY7b4ozMH7BAufGN08ikv523SnKnrr9Q2QMd7lLRKkmuv/76TYOfRK474Y
         p/AW9aJ1Oc+ySonlRJIXLgP5Nld1Qfp0R+Wz7fEBvdpggeYh0sc5qo3QbcUf452GHkUq
         FfLo742t5z1p3YvwtAuBhUn1OQh4t8OyiknIP9nrSfsnYXS4VFcBMl2DGlw2SE/yYiut
         jXxg==
X-Gm-Message-State: AO0yUKXYnckE4cfIzSn557uR9eKWVKPWOeCW9gaxGKg+UupS4KRRuHem
        JBMDdXDYidejzVOhHVnWBcmb0Q==
X-Google-Smtp-Source: AK7set8F0Mg3W7yv3pN3PXL0Nvx7efTKhij6Ak9k9e4QcdPLEg88vQP7bgYLo6RV0siSel2o43lPBA==
X-Received: by 2002:a17:902:cec1:b0:19a:8866:921f with SMTP id d1-20020a170902cec100b0019a8866921fmr4364993plg.54.1677881226043;
        Fri, 03 Mar 2023 14:07:06 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902cf4d00b0019aa8149cc9sm1976029plg.35.2023.03.03.14.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 14:07:05 -0800 (PST)
Message-ID: <64026f89.170a0220.7940.49ff@mx.google.com>
X-Google-Original-Message-ID: <202303031356.@keescook>
Date:   Fri, 3 Mar 2023 14:07:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        syzbot <syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in con_font_op
References: <0000000000001d1fb505f605c295@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001d1fb505f605c295@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 01:37:55PM -0800, syzbot wrote:
> dashboard link: https://syzkaller.appspot.com/bug?extid=3af17071816b61e807ed
> [...]
> usercopy: Kernel memory exposure attempt detected from page alloc (offset 0, size 4194560)!
> [...]
> Call Trace:
>  <TASK>
>  check_heap_object mm/usercopy.c:200 [inline]
>  __check_object_size mm/usercopy.c:251 [inline]
>  __check_object_size+0x50a/0x6e0 mm/usercopy.c:213
>  check_object_size include/linux/thread_info.h:215 [inline]
>  check_copy_size include/linux/thread_info.h:251 [inline]
>  copy_to_user include/linux/uaccess.h:168 [inline]
>  con_font_get drivers/tty/vt/vt.c:4580 [inline]
>  con_font_op+0x397/0xf10 drivers/tty/vt/vt.c:4674

This is coming from the folio checking:

        } else if (folio_test_large(folio)) {
                offset = ptr - folio_address(folio);
                if (n > folio_size(folio) - offset)
                        usercopy_abort("page alloc", NULL, to_user, offset, n);
        }

triggered by copy_to_user of the font.data allocation:

#define max_font_width  64
#define max_font_height 128
#define max_font_glyphs 512
#define max_font_size   (max_font_glyphs*max_font_width*max_font_height)
	...
        font.data = kvmalloc(max_font_size, GFP_KERNEL);
	...
        if (op->data && copy_to_user(op->data, font.data, c))
                rc = -EFAULT;

it is correctly seeing "c" (4194560 in the report) as larger than
"max_font_size" (4194304, seen reported by "folio_size(folio)"). The
"c" calculation comes from:

        unsigned int vpitch = op->op == KD_FONT_OP_GET_TALL ? op->height : 32;
	...
                rc = vc->vc_sw->con_font_get(vc, &font, vpitch);
	...
        c = (font.width+7)/8 * vpitch * font.charcount;

So yes, 4194560 is larger than 4194304, and a memory exposure was,
in fact, blocked here.

Given the recent work in this area, I'm not sure which calculation is
wrong, max_font_size or c. Samuel?

-Kees

-- 
Kees Cook
