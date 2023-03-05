Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786176AB377
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 00:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCEXZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 18:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCEXZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 18:25:03 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD815898
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 15:25:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ec29so787787edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 15:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678058699;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vtfNOBV1Y7YcO0mjhfQU0SAGHEt5vuG5OeRrX+vwP9A=;
        b=V7L6r9KX4yBH/dqCSWtDB0QfaqQNKxWJacQIPE+2UJ4xABxbq8UxWUxMuunMjF1Yex
         KRIAip/D+tcntoEFM2h76n8jnjQHt6byCxcJ1W9QnFReEVJDqXfnsD0X6ov6yjWbcwYe
         qptZF8fMDfgz+EycErbsh+0D0aVl6BFW6in9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678058699;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtfNOBV1Y7YcO0mjhfQU0SAGHEt5vuG5OeRrX+vwP9A=;
        b=wvuqLcBYcs6ORjeeU81WtCL2sFyZFJhcZHFHgy/aNNheOxG7IRWsE3kYOtTro4COkd
         yBUbt6x+BnVt3Qw2qm65qLvKjBWkC8AvUTiRJ/UL5WturjWq4KU08C/f/zof2uiB0Vct
         a17uj/6MrZSPiP5BoqQS9CKr7MZwmoFy2MVaqcysCopeBm9kWAnbwOImYt6d6uiLCyID
         NxXedI+MhV4Yu9q092uG8WJwOGKR7QK5j8QV49PjeR2W2o4b0mmW74gbmF8FjkXHuIbP
         HgL5b8o/pKL/ogH4FnVy0r1ACOz5QvEhw599gtZlaqUp8DdcjzK/EhmnjbMgJ4/Xmt7x
         kg3w==
X-Gm-Message-State: AO0yUKX9YWBsUnEVqrl8Z+USFPzHyHJs8+nN99b3ZrpKQgHq31KYb7p6
        XnYywlSRHZL5flb05Tn4gvUD5Rbe6zqHdOlaorfttA==
X-Google-Smtp-Source: AK7set/7N9hz3+RogoBbaedgD7gKKs5eYOdA3WQ+b/HCtqqKnkElvjBt7leMgNjTt6YaeGSWOD3Jtw==
X-Received: by 2002:a17:906:10d8:b0:8aa:c2e1:6a64 with SMTP id v24-20020a17090610d800b008aac2e16a64mr10245678ejv.61.1678058699312;
        Sun, 05 Mar 2023 15:24:59 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id kk14-20020a170907766e00b008ee84860964sm3741422ejc.35.2023.03.05.15.24.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 15:24:58 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id cw28so31652795edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 15:24:58 -0800 (PST)
X-Received: by 2002:a17:906:498e:b0:901:e556:6e23 with SMTP id
 p14-20020a170906498e00b00901e5566e23mr4115715eju.0.1678058698291; Sun, 05 Mar
 2023 15:24:58 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Mar 2023 15:24:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
Message-ID: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
Subject: Linux 6.3-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So after several releases where the merge windows had something odd
going on, we finally had just a regular "two weeks of just merge
window". It was quite nice.

In fact, it was quite nice in a couple of ways: not only didn't I have
a hugely compressed merge window where I felt I had to cram as much as
possible into the first few days, but the fact that we _have_ had a
couple of merge windows where I really asked for people to have
everything ready when the merge window opened seems to have set a
pattern: the bulk of everything really did come in early.

And again, that just makes the merge window work nicer for me, when I
don't sit there waiting, knowing that there's stuff pending that just
hasn't had a pull request done yet.

So it all felt rather good. Of course, the fact that I had no machine
issues, no holidays, and no travel coming up, then meant that I may
have noticed a few more of the "people, please write good commit
messages for merges" issues, so there's a possible downside to me not
being as hurried as the last few merge windows have been.

And of course, smooth or not, now that the merge window is closed, we
need to make sure it all *works*. We had a couple of exciting merges
already, and I think the fallout from that got sorted out, but I'm
sure there's more to come. Let's hope the calming-down period of 6.3
works as well as the merge window did... Knock wood.

Anyway, as always, the shortlog is much too large to post, since we
had 12500+ commits (and that's not counting the merges - closer to a
thousand of those). So below is just my usual merge log which gives
only a very high-level view of what I merged and from who. It all
looks fairly normal, with ~55% of the patch being drivers, ~20% being
architecture updates. and the rest being the usual random mix
(documentation, tooling, networking, filesystem, and just core kernel
stuff).

Please do test,

                Linus

---

Al Viro (8):
    minix updates
    sysv updates
    alpha updates
    ipc namespace update
    misc vfs updates
    alpha updates
    VM_FAULT_RETRY fixes
    vfs update

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (3):
    MM updates
    non-MM updates
    misc fixes

Anna Schumaker (1):
    NFS client updates

Ard Biesheuvel (1):
    EFI updates

Arnaldo Carvalho de Melo (1):
    perf tools updates

Arnd Bergmann (7):
    ARM SoC updates
    ARM defconfigs updates
    SoC DT updates
    asm-generic cleanups
    ARM SoC driver updates
    ARM SoC fixes
    ARM SoC boardfile updates

Bartosz Golaszewski (1):
    gpio updates

Benjamin Tissoires (1):
    HID updates

Bjorn Andersson (3):
    hwspinlock updates
    rpmsg updates
    remoteproc updates

Bjorn Helgaas (1):
    PCI updates

Borislav Petkov (7):
    RAS updates
    EDAC updates
    x86 asm alternatives updates
    x86 resource control updates
    x86 microcode loader updates
    x86 vdso updates
    x86 cpuid updates

Casey Schaufler (1):
    smack update

Catalin Marinas (2):
    arm64 updates
    arm64 fixes

Christian Brauner (3):
    vfs idmapping updates
    vfs hardening update
    vfs acl update

Christoph Hellwig (1):
    dma-mapping updates

Chuck Lever (2):
    nfsd updates
    nfsd fix

Corey Minyard (1):
    IPMI updates

Damien Le Moal (3):
    ATA updates
    zonefs updates
    ATA fix

Dan Williams (1):
    Compute Express Link (CXL) updates

Darrick Wong (3):
    iomap updates
    xfs updates
    moar xfs updates

Dave Airlie (2):
    drm updates
    drm fixes

Dave Hansen (1):
    Intel Trust Domain Extensions (TDX) updates

Dave Kleikamp (1):
    jfs update

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Eric Biggers (2):
    fscrypt updates
    fsverity updates

Eric Van Hensbergen (1):
    9p updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (6):
    USB / Thunderbolt driver updates
    tty / serial driver updates
    staging driver updates
    char/misc and other driver subsystem updates
    driver core updates
    driver core fixes

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

Guo Ren (1):
    csky update

Gustavo Silva (1):
    flexible-array updates

Hans de Goede (1):
    x86 platform driver updates

Heiko Carstens (2):
    s390 updates
    more s390 updates

Herbert Xu (2):
    crypto update
    crypto fix

Huacai Chen (1):
    LoongArch updates

Ilya Dryomov (1):
    ceph fixes

Ingo Molnar (11):
    locking updates
    perf updates
    scheduler updates
    x86 asm updates
    x86 boot updates
    x86 build update
    x86 core updates
    x86 fpu updates
    x86 mm update
    x86 platform update
    objtool updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (2):
    networking updates
    networking fixes

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (2):
    fsnotify updates
    UDF and ext2 fixes

Jarkko Sakkinen (1):
    tpm updates

Jason Gunthorpe (2):
    iommufd updates
    rdma updates

Jassi Brar (1):
    mailbox updates

Jeff Layton (2):
    file locking updates
    i_version updates

Jens Axboe (6):
    io_uring updates
    io_uring ITER_UBUF conversion
    legacy dio update
    block updates
    block fixes
    more io_uring updates

Jens Wiklander (1):
    TEE update

Joerg Roedel (1):
    iommu updates

John Paul Adrian Glaubitz (1):
    sh updates

Jonathan Corbet (2):
    documentation updates
    Documentation stragglers

Juergen Gross (1):
    xen updates

Julia Lawall (1):
    coccinelle updates

Kees Cook (2):
    seccomp update
    hardening updates

Lee Jones (3):
    MFD updates
    backlight updates
    LED updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (2):
    modules updates
    sysctl update

Mark Brown (5):
    regmap updates
    regulator updates
    spi updates
    regulator fixes
    spi fixes

Masahiro Yamada (1):
    Kbuild updates

Masami Hiramatsu (3):
    kprobes updates
    bootconfig updates
    kprobes cleanup updates

Mauro Carvalho Chehab (1):
    media updates

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio updates

Micka=C3=ABl Sala=C3=BCn (1):
    landlock updates

Miguel Ojeda (3):
    Rust updates
    auxdisplay fix
    Rust fix

Mike Rapoport (1):
    memblock updates

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (1):
    fuse updates

Mimi Zohar (1):
    integrity update

Miquel Raynal (1):
    MTD updates

Namjae Jeon (1):
    exfat updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Bonzini (1):
    kvm updates

Paul McKenney (5):
    RCU updates
    LKMM (Linux Kernel Memory Model) updates
    x86 NMI diagnostics
    nolibc updates
    kernel concurrency sanitizer (KCSAN) updates

Paul Moore (1):
    audit update

Petr Mladek (2):
    printk updates
    livepatching updates

Rafael Wysocki (6):
    power management updates
    ACPI updates
    thermal control updates
    more power management updates
    more ACPI updates
    more thermal control updates

Richard Weinberger (2):
    jffs2, ubi and ubifs updates
    UML updates

Rob Herring (1):
    devicetree updates

Russell King (1):
    ARM udpates

Sebastian Reichel (2):
    power supply and reset updates
    more power supply updates

Shuah Khan (2):
    Kselftest update
    KUnit update

Stephen Boyd (1):
    clk updates

Steve French (3):
    ksmbd server updates
    cifs client updates
    more cifs updates

Steven Rostedt (4):
    ktest updates
    tracing tools updates
    tracing fix
    tracing updates

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (2):
    workqueue updates
    cgroup updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (2):
    MIPS updates
    more MIPS updates

Thomas Gleixner (5):
    miscellaneous x86 cleanups
    timer updates
    irq updates
    irq updates
    x86 updates

Tzung-Bi Shih (1):
    chrome platform updates

Ulf Hansson (1):
    MMC updates

Vinod Koul (3):
    dmaengine updates
    phy updates
    soundwire updates

Vlastimil Babka (1):
    slab updates

Wei Liu (1):
    hyperv updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    more i2c updates
