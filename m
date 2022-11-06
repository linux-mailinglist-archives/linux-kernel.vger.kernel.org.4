Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3B61E4B0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKFROG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiKFRNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:13:46 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76074FCDA
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 09:08:16 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j25-20020a056830015900b0066ca2cd96daso1799434otp.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sdm1aqC3iYVLiyqHOars6qR5+zLBCLJ8sR0X+nJVaKQ=;
        b=eYh2iVCke5csROhCLp2TIBHjl+9fJkZ5vZxdSbwDnJJGJoP992D17UVzckCv3l4Sn5
         hFQ4dF3uiOkpb+J8fetCWhpjztltFbEefqX7WlD3uNzIFwIYEPDnpB+lucMOG2QlNW4q
         LAuI1keeGv/yLu7PGz78qtHKP5LBJufjMhZEQzM7G3Gbnr8oiWLgrnyjrk1Ton7VFpD0
         vMTNyEsDh/wfLVxcz8utYpk+4dbL3Y9hNjd7TmOniIBmYCikyIl/F/6XjOZRaxLNQq72
         64fje1uKmq2lpfhT5t/VoK+8sCXo4xLDWTfonZ/+GXsxfc89p7EPPFhrTeOqluJ3UVvJ
         a50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sdm1aqC3iYVLiyqHOars6qR5+zLBCLJ8sR0X+nJVaKQ=;
        b=car0qp0wTuMfztuVpUcG8I6VhdW68dQn0VMuUrXP2sz+WP0iyRUqufCk40NNZxWUEp
         /hPOcOBmgt6fa7Hlt8hmuqoijp3uczqjUWBlCtKzV8WGb8ypmh29klnzUiK66UaLXiMP
         QUs0MCTG6gvZs0Ph74bkm4cQmCMIhKAlfJ38Jjz/9nFXWKO4hGP/r00wt9r2olCNnJOA
         8Sd4gt+ojlfKgG51cSatjRG0L8EM6xLT7BMR/S6GKAReBSPt/v9uONBosjHpujqLl3zi
         eCSw5EcqEd5j7ftLNMCOym8hQrDm9r7wTFntEGoPq1+NkLpfWfOqBGG4vvymtvU3WWqt
         zgrQ==
X-Gm-Message-State: ACrzQf0nnU7QR9eldEmomkVRBR8+ZiPnet4La1toJEoN919tyANBX3G+
        JbewVzBGWy0rm27Y6PomtXmYmIjhIPU=
X-Google-Smtp-Source: AMsMyM7EORDhQpzi/NEfAEiTpqYDq9kR6UNFBu9hpKfcZdzQ7M1DutPB1vgScRPAcqIZa/+QSOG/+A==
X-Received: by 2002:a9d:1c1:0:b0:66c:846:6a4b with SMTP id e59-20020a9d01c1000000b0066c08466a4bmr22040953ote.65.1667754495228;
        Sun, 06 Nov 2022 09:08:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h19-20020a9d6a53000000b0066aba96addbsm2029222otn.81.2022.11.06.09.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 09:08:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Nov 2022 09:08:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5a 0/5] timers: Use timer_shutdown*() before freeing
 timers
Message-ID: <20221106170811.GA105056@roeck-us.net>
References: <20221106054535.709068702@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106054535.709068702@goodmis.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 01:45:35AM -0400, Steven Rostedt wrote:
> 
> del_timer_sync() is often called before the object that owns the timer is
> freed. But sometimes there's a race that enables the timer again before it is
> freed and causes a use after free when that timer triggers. This patch set
> adds a new "shutdown" timer state, which is set on the new timer_shutdown()
> API. Once a timer is in this state, it can not be re-armed and if it is, it
> will warn.
> 
> The first three patches change existing timer_shutdown() functions used
> locally in ARM and some drivers to better namespace names.
> 
> The fourth patch implements the new API.
> 
> The fifth patch is now a treewide patch that uses a coccinelle script to
> convert the trivial locations where a del_timer*() is called on a timer of an
> object that is freed immediately afterward (or at least in the same function).
> 

Series looks good in my testbed.

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 500 pass: 500 fail: 0

No runtime warnings reported.

For the series:

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
