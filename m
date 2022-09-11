Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75CA5B4EA5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiIKMBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 08:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIKMBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 08:01:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2D232EE5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 05:01:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l12so7475108ljg.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eBGzSiuctdtKY9Qsp3sP8qBpPaicy+2nwjL/q6AwtQc=;
        b=SMdWzqWkIa6MWyvZKBP4R1WG8PemK+5S/bpbE368D+7fKifMIn06u87l4CKYMGDgvq
         uOskkjiwy35Bzd1Dhb36cQ7CMcbchDq/4EO/ErQP3ASGVLJvo4jyWeYOIO2IYAq78Wpk
         GKQ4z1oxZ1PK0PZhdjbcVZG0kdOlzKJeVfCpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eBGzSiuctdtKY9Qsp3sP8qBpPaicy+2nwjL/q6AwtQc=;
        b=nE7wDE9ffV5TTxDjCgcPSLJjbtcaFv4EVasCMXilHcPsPS4ip961Q+757nDK9PCWtg
         DI6lkh0HRdAP2F7f6Kx5ac+LqcnmN/SlobAxse7BgarmwPxRIDUlo6FcF4486L74qRjK
         vTuha+fE8bHKf8fH+1D41EiuEKBlR7lnnV+Z/Fiit/XuGwrH3hubXNm7435ygjhp9oJb
         MXLECcqxjdosdd6lR6AQQ4pL9SwyhBKrKL2SkUMzX2St3iioba46rMzHlEHUtLu5jv9a
         7Hojnf+S7JrE3Z3K/5tDWyO+8+XkISm5TYaXmKNTIiNAjychTMSfHxOFn/DLmuEh9nKn
         cKpw==
X-Gm-Message-State: ACgBeo1J7DQgszrqL4n1WnIEKOU+x+qg42iY4KP4E7BiCZA3hu3MQHtL
        8EI7HmBfyFSfCSYA8VCJhSceFqJ6hRO1YFrz
X-Google-Smtp-Source: AA6agR6s9H7Rj6m+LKHKaK+fpZr/k68RlO3XjLI9f3M9y6+314BYzNeUppPCYM7B4BCAszulAEeCCA==
X-Received: by 2002:a05:651c:1033:b0:26a:aa02:b0fa with SMTP id w19-20020a05651c103300b0026aaa02b0famr7052646ljm.82.1662897699801;
        Sun, 11 Sep 2022 05:01:39 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a23-20020ac25e77000000b00492ea54beeasm580317lfr.306.2022.09.11.05.01.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 05:01:38 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id o2so8306209lfc.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 05:01:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3d16:b0:498:f04f:56cf with SMTP id
 d22-20020a0565123d1600b00498f04f56cfmr5822982lfv.612.1662897698202; Sun, 11
 Sep 2022 05:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220910221947.171557773@linutronix.de>
In-Reply-To: <20220910221947.171557773@linutronix.de>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Sun, 11 Sep 2022 08:01:21 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj=CBxrztv0gs273zovMRNsG=i1jg-rf3d-aAx4WLEF1w@mail.gmail.com>
Message-ID: <CAHk-=wj=CBxrztv0gs273zovMRNsG=i1jg-rf3d-aAx4WLEF1w@mail.gmail.com>
Subject: Re: [patch RFC 00/29] printk: A new approach - WIP
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 6:27 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> After taking a step back we decided to go for a radically different
> approach:

From a quick look through the patches this morning, I see nothing
alarming. The proof is in the pudding, but this seems to have a sane
model for console list handling and for handling the individual
console states.

But I'm on a laptop and only read through the patches while going
through my email this morning, so I may well have missed something.

                 Linus
