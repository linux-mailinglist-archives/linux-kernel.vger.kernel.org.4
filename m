Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B855F61171F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiJ1QJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiJ1QJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:09:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F349F220F98;
        Fri, 28 Oct 2022 09:07:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y14so13992739ejd.9;
        Fri, 28 Oct 2022 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lD+pA5E2PNMxHP5NE3vNozzPpwCUBIHi+D6BtibFHBk=;
        b=MCRMjTQyuhwiic2rx3/v6/6wv5tUBlNUxyTBXfCrem/HTZd6Q5qYN15Vtr8kcgICu8
         BRhNj8V3nAk/I4EmIKMR5oL24I/CbxITjPj0aE9JdJFDqDvVKcEgaT5aTVY5OgOZHcFN
         4iPuwdHdZe+8NaB/mNBZW7O1eVPJ96D9yY4K1bVN74WjgtbpkuQiDnKyvJRjzMTQs3Dk
         erAqUISOiz9VnpZ8Y3/Gd2BpsnYRD7dLLe5or3g4yOznJWJatofGqAmXsPLu0mQfU0er
         VEcYbahqVD39i7eqvfv/tDEmhCuYC/oItPDqanRqNxqBlG/xdN1ITvfPH/B6kXRzgFI2
         p+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD+pA5E2PNMxHP5NE3vNozzPpwCUBIHi+D6BtibFHBk=;
        b=nXllAd5SAhc90p+w5GWqTV3EdIb5rqBhrqXMWVfIiWNMVB0tdF4Q5nrMBnx7O8BhP0
         dVE8pqhIrRZLWILUm4ZhF2X1hGJzgOl0AfQX4LL644wKtz3whG0a7nhmO7q55qzVbogf
         ObO8vT5dvHfVVSQNMoBZZS8zaAai/IrArB4WIZtD39uyg+29dPQQS8HaGf1d27w7RPrM
         eLgIj7ylz7pev5Ed5SsJBG4MVODDvarcLQMEkjuobjvuAPsoGaSIvlyduHkamMEIVRIs
         IQ+9YqE5PjWeYn8kNLQLO0SSQ9NZBFwKwDQlutUwP6sfodlTNT0ENXXsO+j8iWu/bjch
         j+NA==
X-Gm-Message-State: ACrzQf3afJZiqTMVtRyzsE5gBsBdgk62kus86Xnj9LvjRTh0zf9G19mS
        GOGi1ci1aW7EzcJy49qolK94wjVmZvnqzm1fzX8=
X-Google-Smtp-Source: AMsMyM76cFhYbRy1BTy6Nv2FnQl9QDQ+2TmzHjytA9QtTA7YnSxuEYgxNhvPaKIQLqQDevlFZ09jBU6yII5qJB1owVU=
X-Received: by 2002:a17:907:728b:b0:7a1:b545:b39b with SMTP id
 dt11-20020a170907728b00b007a1b545b39bmr27114ejc.661.1666973246450; Fri, 28
 Oct 2022 09:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <Y1vZKg6UHjdUZt1W@debian> <fcd3d702-d645-2847-d8ee-0fb4734258c6@intel.com>
In-Reply-To: <fcd3d702-d645-2847-d8ee-0fb4734258c6@intel.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 28 Oct 2022 17:06:50 +0100
Message-ID: <CADVatmN-iM6mhWo+R1hDBvw_qg=NBdccSDQ2104A2JxZLBkExw@mail.gmail.com>
Subject: Re: boot failure of linux-next due to 1248fb6a8201 ("x86/mm:
 Randomize per-cpu entry area")
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 3:33 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/28/22 06:29, Sudip Mukherjee (Codethink) wrote:
> > I will be happy to test any patch or provide any extra log if needed.
> > Though I am not sure how I will collect extra logs (if needed) as there
> > was no output from qemu.
>
> Could you share your qemu config?  The command-line would be fine.  Does
> it have a serial console set up?

qemu-system-x86_64 -m 2048 -smp 2 -chardev
socket,id=SOCKSYZ,server,nowait,host=localhost,port=46514 -mon
chardev=SOCKSYZ,mode=control -display none -serial stdio -no-reboot
-name VM-test -device virtio-rng-pci -enable-kvm -cpu
host,migratable=off -device e1000,netdev=net0 -netdev
user,id=net0,restrict=on,hostfwd=tcp:127.0.0.1:28993-:22 -hda
bullseye.img -snapshot -kernel bzImage -append "root=/dev/sda
console=ttyS0 net.ifnames=0 biosdevname=0"

serial is via stdio, and in normal boots I get the bootlog in the
terminal, but in this case there was nothing.


-- 
Regards
Sudip
