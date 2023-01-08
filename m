Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B509661A76
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 23:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjAHW1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 17:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjAHW1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 17:27:34 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE44312
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 14:27:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s9so6457940wru.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 14:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQf3Expb1rUJy7Rc44uGIHPD++uoDqXzbvOEJjmuv5w=;
        b=P/96NHTU7SYFmfz1qIfcnv24h7ukpc4hM8EvE5zf/iNQj6s+tjxPXgkxtogtRztR/f
         IfMUvMww7Qyop7gvTiGvhlG4Ik0wr6jl8WZWeiBw/coZIk9ap26aR9lUGX7ocRcpgUD8
         WOCcgAn8A/Rnop0inYzMlyrOz1gK4vppMFE1NIvUdcgV7izG9GTOvMc1pxHhHU3GmLQL
         ckk9q6cqTdiAFjXYsafBYZy7AMgr2cZmKLS64R4Ptzkb1Jz+aTEIQFgp+m45dRQt3LOa
         eUVeYjvznkBtcTuvvuR0VYx96pITFG/+2/2zvVnWm7okUTS8iLe+Ng+gosjz9XNu0KIl
         m78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQf3Expb1rUJy7Rc44uGIHPD++uoDqXzbvOEJjmuv5w=;
        b=bQvvCZIN2DdFlzzvVt9ONy5gFyTLQnNkvBGp4xsa015OqvjmMGZeA7uJa3yA/MrwBS
         SZGfB7X9Ch4AIamxcc30DvNbqfDbFFlPqI42g3yi1tkIWYJQ5cZJYx7TmhOY5hhDiTZU
         NeVkGPsQTwRTs/xrnFqWeDTbyrfQpYlKB6YggGd7BwPDvHAVDkHLo1PtXimQtJkixG88
         xZmGH1zaNZFy0WQZqIKR0ws7bZaWqL1FqIOIhdHX0Sqbd1mxQkjxr2a+Hk4Du/eQh52O
         v4T9n2/6ZlQVhm14k0qJKif1EjKc+kJ+E0mcEvbuGye/Y565sRGM0gPU5pw3rU2oTjte
         xy1g==
X-Gm-Message-State: AFqh2koSpwC7wYJ0k8M0HpDs/SrG83BHk1xhS9igCdq9GgGT9OOIzB+E
        bsbjgZKXqkp6/4uY1Cvk9ms9dbCo72OqOpH3
X-Google-Smtp-Source: AMrXdXsFWpKMrLEGqjcEU3n+lLE634MJbddjbNrARB14xpX1Ij7MfOSsgBPyF8o8Hw2hXNjYSw4L0Q==
X-Received: by 2002:adf:fe87:0:b0:274:fae4:a512 with SMTP id l7-20020adffe87000000b00274fae4a512mr34257258wrr.71.1673216849974;
        Sun, 08 Jan 2023 14:27:29 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d5007000000b0023662d97130sm6944485wrt.20.2023.01.08.14.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 14:27:29 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
Date:   Sun,  8 Jan 2023 22:27:28 +0000
Message-Id: <20230108222728.69350-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <Y7s1Ubyxfdz9V+sp@zn.tnic>
References: <Y7s1Ubyxfdz9V+sp@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can also reproduce it on my Ryzen 5700G (both real and QEMU+KVM).
So it doesn't appear to be Intel or AMD specific.

Perhaps your BIOS/UEFI keeps the value of %gs or it points somewhere
valid after waking from suspend to RAM, and the ones I have don't?
That's a way I can imagine it not crashing on some HW.
If that's the case, you should still be able to reproduce it on QEMU.

Or it's also possible that the QEMU issue is different from the one on
real HW (though unlikely, I think)
