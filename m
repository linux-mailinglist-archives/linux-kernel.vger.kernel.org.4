Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87519655E6A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 23:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiLYWH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 17:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYWHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 17:07:25 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA0526F5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 14:07:23 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j16so7501474qtv.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 14:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+yzlTk7HKPbBV93L8lnOkZ8lSUpBKNYYV9DNqRdvLPA=;
        b=Q0CEDG+0k0gSFjyutW2Bp0KRcBXAnhhpXoHxVt/rpH0bOtczK2N2f5xoZWclEoV7XB
         Nh/q71iIzMVbYTYRc54JkP5nlTl6YQLyLDebzIJFQ1OP+XYOF/4WHIijr6UO/jtRgnWR
         VeD89ISN6gVPjIL/79FvWCZvg6K8bFnSGXgGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yzlTk7HKPbBV93L8lnOkZ8lSUpBKNYYV9DNqRdvLPA=;
        b=G1wqYQLUuM+QvedWvLnArA6ex44rSIMPE+h0h+7jAi9+cvrkYu5+hiyePQ49TEIzhb
         ZjKTcBDw1cDC8Sm993HjTtSAX+/wKxiH5A1HAJT2ukS9FhMEcKZz3aM60gwzYEM6pC8J
         UpMalM2ePvrlV6Tuujfdr97SjqbARLCOoztuKQNtyaSXUNf3q5dTw15fzSEA1Xkl8kmW
         umlpflwRqlFAIPARfOactGDKfDEuVG2WKJpiOsUNtysy4d3HviAa6vs1+MVPTQofoef8
         OgQJmAW1tW9yEkyq17j46AHd9IhOYlTESbSyMeDjy/sfUOBFsGfd5YH6AUzXuHqRf3nr
         qabw==
X-Gm-Message-State: AFqh2krGkgCO+EXyykmIdM7ZxuE0FJ8Sc6sKmC4hrOchj/ebhZi1ft0A
        Gk2D9FA8t7T3FgmtOQ69i8pTC7Io60PzT2gr
X-Google-Smtp-Source: AMrXdXupTae4ICxGFfDfGQO0mrxYUOtpc+WQcw6ey3awHxz52mbP/SYeNKSVaNbIzxR+/DvOg17HIQ==
X-Received: by 2002:ac8:678b:0:b0:3a9:902d:414e with SMTP id b11-20020ac8678b000000b003a9902d414emr21712763qtp.15.1672006042275;
        Sun, 25 Dec 2022 14:07:22 -0800 (PST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id bi1-20020a05620a318100b006f7ee901674sm6677916qkb.2.2022.12.25.14.07.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 14:07:21 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id i12so6600065qvs.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 14:07:21 -0800 (PST)
X-Received: by 2002:a0c:df09:0:b0:4f0:656b:c275 with SMTP id
 g9-20020a0cdf09000000b004f0656bc275mr1091789qvl.129.1672006040790; Sun, 25
 Dec 2022 14:07:20 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Dec 2022 14:07:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
Message-ID: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
Subject: Linux 6.2-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it's Christmas Day here, but it's also Sunday afternoon two weeks
after the 6.2 merge window opened. So holidays or not, the kernel
development show must go on.

Thanks to a lot of people sending their pull requests early, I got
much of the merge window work done before the holidays started in
earnest, and mostly before my pre-xmas travel. So despite flight
delays, missed connections, and the resulting airport hotel
excursions, the merge window mostly went smoothly, and there was no
reason to delay rc1.

That said, realistically I expect most people to be on vacation for at
least another week, so I wouldn't be surprised if we end up with a
delayed final release due to the season. But it's too early to worry
about that yet, we'll just have to see how it goes.

Also, 6.2 looks like it's a bigger release (certainly bigger than 6.1
was). The summary below is, as usual, just my merge log: we've got
about 13.5k commits from ~1800 people in total in this merge window,
which is actually not that far off the total size of the whole 6.1
release. But let's hope that despite the size, and despite the likely
slow start of the post-merge-window calming down period, we'll have a
smooth release.

And in the meantime, Merry Christmas and a Happy New Year to all
(replace as appropriate with whatever holiday, if any, you are
celebrating).

                   Linus

---

Al Viro (5):
    elf coredumping updates
    alpha updates
    iov_iter updates
    namespace fix
    misc vfs updates

Alex Williamson (1):
    VFIO updates

Alexander Gordeev (1):
    s390 updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updtaes

Andrew Morton (5):
    non-MM updates
    MM updates
    more mm updates
    fault-injection updates
    hotfixes

Ard Biesheuvel (1):
    EFI updates

Arnaldo Carvalho de Melo (2):
    perf tools updates
    more perf tools updates

Arnd Bergmann (6):
    ARM SoC defconfig updates
    ARM SoC code updates
    ARM SoC driver updates
    ARM SoC DT updates
    ARM SoC fixes
    asm-generic updates

Bartosz Golaszewski (1):
    gpio updates

Benjamin Tissoires (1):
    HID updates

Bjorn Andersson (1):
    remoteproc updates

Bjorn Helgaas (1):
    PCI updates

Borislav Petkov (10):
    EDAC updates
    x86 RAS updates
    x86 alternative update
    x86 asm updates
    x86 boot updates
    x86 cpu updates
    x86 microcode and IFS updates
    x86 paravirt update
    x86 sev updates
    x86 core updates

Christian Brauner (7):
    VFS acl updates
    setgid inheritance updates
    vfsuid updates
    idmapping updates
    simple-xattr updates
    vfsuid cleanup
    mount propagation fix

Christoph Hellwig (3):
    configfs updates
    dma-mapping updates
    dma-mapping fixes

Chuck Lever (2):
    nfsd updates
    more nfsd updates

Corey Minyard (1):
    IPMI updates

Damien Le Moal (1):
    ata updates

Dan Williams (1):
    cxl updates

Darrick Wong (3):
    vfs remap_range update
    iomap update
    XFS updates

Dave Airlie (2):
    drm updates
    drm fixes

Dave Hansen (6):
    x86 sgx updates
    x86 tdx updates
    x86 cache resource control updates
    x86 splitlock updates
    x86 fpu updates
    x86 mm updates

David Howells (1):
    afs update

David Kleikamp (1):
    jfs updates

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Dennis Zhou (1):
    percpu updates

Dmitry Torokhov (1):
    input updates

Dominique Martinet (1):
    9p updates

Eric Biggers (2):
    fscrypt updates
    fsverity updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (6):
    USB and Thunderbolt driver updates
    staging driver updates
    tty/serial driver updates
    char/misc driver updates
    driver core updates
    SPDX/License additions

Greg Ungerer (1):
    m68knommu update

Guenter Roeck (1):
    hwmon updates

Guo Ren (1):
    arch/csky updates

Hans de Goede (1):
    x86 platform driver updates

Helge Deller (2):
    fbdev updates
    parisc updates

Herbert Xu (1):
    crypto updates

Huacai Chen (1):
    LoongArch updates

Ilya Dryomov (1):
    cph update

Ingo Molnar (3):
    locking updates
    perf events updates
    scheduler updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (1):
    networking fixes

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (1):
    udf and ext2 fixes

Jarkko Sakkinen (1):
    tpm updates

Jason Donenfeld (3):
    unsigned-char conversion
    random number generator updates
    more random number generator updates

Jason Gunthorpe (3):
    iommufd implementation
    rdma updates
    rdma fixes

Jassi Brar (1):
    mailbox updates

Jeff Layton (1):
    file locking updates

Jens Axboe (6):
    io_uring updates
    io_uring updates part two
    block updates
    writeback updates
    io_uring fixes
    block fixes

Jiri Kosina (1):
    HID updates

Joerg Roedel (1):
    iommu updates

John Johansen (1):
    apparmor updates

Jonathan Corbet (1):
    documentation updates

Juergen Gross (1):
    xen updates

Julia Lawall (1):
    coccicheck update

Kees Cook (6):
    pstore updates
    seccomp updates
    execve updates
    kernel hardening updates
    pstore fixes
    kernel hardening fixes

Konstantin Komarov (1):
    ntfs3 updates

Lee Jones (2):
    MFD updates
    backlight update

Linus Walleij (1):
    pin control updates

Luis Chamberlain (2):
    modules updates
    sysctl updates

Marc Zyngier (1):
    MSI fixes

Mark Brown (5):
    regmap updates
    regulator updates
    spi updates
    regulator fixes
    spi fix

Masahiro Yamada (1):
    Kbuild updates

Mauro Carvalho Chehab (2):
    media updates
    media fixes

Max Filippov (1):
    Xtensa updates

Michael Ellerman (1):
    powerpc updates

Michal Simek (1):
    microblaze updates

Micka=C3=ABl Sala=C3=BCn (1):
    landlock updates

Miguel Ojeda (1):
    rust updates

Mike Marshall (1):
    orangefs updates

Mike Rapoport (1):
    memblock updates

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (2):
    overlayfs update
    fuse update

Mimi Zohar (1):
    integrity updates

Miquel Raynal (1):
    mtd updates

Namjae Jeon (1):
    exfat update

Nick Terrell (1):
    zstd updates

Palmer Dabbelt (1):
    RISC-V updates

Paolo Abeni (1):
    networking updates

Paolo Bonzini (2):
    kvm updates
    RISC-V kvm updates

Paul McKenney (5):
    RCU updates
    kernel memory model documentation updates
    KCSAN updates
    nolibc updates
    RCU fix

Paul Moore (3):
    audit updates
    selinux updates
    lsm updates

Pavel Machek (1):
    LED updates

Petr Mladek (2):
    printk updates
    livepatching update

Rafael Wysocki (5):
    power management updates
    ACPI and PNP updates
    thermal control updates
    more thermal control updates
    more ACPI updates

Rob Herring (2):
    devicetree updates
    more devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    power supply and reset updates
    HSI updates

Seth Forshee (2):
    squashfs update
    xattr audit fix

Shuah Khan (2):
    Kselftest updates
    KUnit updates

Stephen Boyd (1):
    clk driver updates

Steve French (3):
    ksmbd updates
    cifs client updates
    cifs fixes

Steven Rostedt (5):
    ktest updates
    tracing tools updates
    tracing updates
    trace probes updates
    tracing fix

Takashi Iwai (2):
    sound updates
    more sound updates

Ted Ts'o (1):
    ext4 updates

Tejun Heo (1):
    cgroup updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (2):
    MIPS updates
    MIPS fixes

Thomas Gleixner (8):
    x86 fixes
    debugobjects update
    irq updates
    CPU hotplug updates
    x86 apic update
    x86 cleanups
    timer updates
    misc x86 updates

Trond Myklebust (1):
    NFS client updates

Tzung-Bi Shih (1):
    chrome platform updates

Ulf Hansson (1):
    MMC and MEMSTICK updates

Vinod Koul (3):
    phy updates
    soundwire updates
    dmaengine updates

Vlastimil Babka (1):
    slab updates

Wei Liu (1):
    hyperv updates

Will Deacon (2):
    arm64 updates
    arm64 fixes

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates
