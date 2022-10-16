Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28195600416
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJPXB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJPXBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:01:54 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC533121F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 16:01:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id y72so10510755oia.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 16:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUpCJq0BZ7RHiGaS0r43bMvGfZYze5hPLVIakOd11sk=;
        b=ZRugkFnK6li0+r/IEhsb9EleHWVY9WpLKYXSWoou8c9WESe+KjuKsuk8Vi6HWoq3mx
         rq6wswxxfhzT9w1rhZGWVoANpVjdHaEOm2grYrjfUS2as4rcoZS6QGBV1wR7rKSGaws3
         5m/fmSOMg88z344XIHdSuf50rtHDLzoKPSETI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUpCJq0BZ7RHiGaS0r43bMvGfZYze5hPLVIakOd11sk=;
        b=ibhWatQOonIy63iiFUU3yB2woXgIKZlZBZ2fD7IgDUAc7mrY9bytj0vWDOFj2OntKk
         +ttt77wUWa66sdMztJ50IOUPlvpD2gIiBDjMzthPzevwfR2KvLmcquJTF+a52bKQ9IFC
         sUG09QZUhQpzwa80dQuqguR3KV+/x3fG9k+mueB/j47Z4mOlEPDbwzcwfSMihcabGF0L
         b7QMAPsnpcN3D/sVH+P58D9l5KdHyPFGsO9xGhnZQgi/5UpLyZq4NZHzBjXkKyKTnsEA
         g2HtGCqf9Fbainn6bEVt1C6qZ4ZI1mdj9GumRvF82eQhDHrpdAqyO3vTL3sLFht4xZh5
         aR1Q==
X-Gm-Message-State: ACrzQf11O4aRfTcegpQAl1Q1n489tcxAj3Lybf2V4RBcR6p/F85x2mBs
        fZBeRPCgMoUbhAPqzFBAjEnJOzEWdnCQVA==
X-Google-Smtp-Source: AMsMyM6g+EMKpivb5FJEmYs9BzfFcR3Vd/gJl3PBERb68PWnn5oCgP4Pb3HTlV+tuLLnF3/L2BWUuA==
X-Received: by 2002:a05:6808:ec3:b0:353:f1b2:ba91 with SMTP id q3-20020a0568080ec300b00353f1b2ba91mr11990828oiv.216.1665961311266;
        Sun, 16 Oct 2022 16:01:51 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id h7-20020a9d61c7000000b00661c3846b4csm4130589otk.27.2022.10.16.16.01.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 16:01:50 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id t4-20020a9d7f84000000b00661c3d864f9so4892549otp.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 16:01:50 -0700 (PDT)
X-Received: by 2002:a05:6830:4408:b0:661:dfa1:f018 with SMTP id
 q8-20020a056830440800b00661dfa1f018mr3732335otv.69.1665961309871; Sun, 16 Oct
 2022 16:01:49 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Oct 2022 16:01:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
Message-ID: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
Subject: Linux 6.1-rc1
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

You all know the drill: it's Sunday afternoon, the two weeks of merge
window are over, and now we're supposed to start calming things down.

This isn't actually shaping up to be a particularly large release: we
"only" have 11.5k non-merge commits during this merge window, compared
to 13.5k last time around. So not exactly tiny, but smaller than the
last few releases. At least in number of commits.

That said, we've got a few core things that have been brewing for a
long time, most notably the multi-gen LRU VM series, and the initial
Rust scaffolding (no actual real Rust code in the kernel yet, but the
infrastructure is there).

And hey, this merge window was full of surprises for other reasons too
- my main machine was basically out of action for a couple of days
because it suddenly started showing memory problems, and it took me a
couple of days to get that sorted out (to a large degree because it
was unexpected and I started out blaming a kernel bug for the memory
corruption). All sorted out now, but it caused some frustration.

Talking about frustration, let me just say that after I got my machine
sorted out and caught up with the merge window, I wass somewhat
frustrated with various late pull requests. I've mentioned this
before, but it's _really_ quite annoying to get quite a few pull
requests in the last few days of the merge window.

Yes, the merge window is two weeks, but that's very much to allow me
time to look things over, not "two weeks to hurriedly put together a
branch that you send Linus on Friday of the second week". The whole
"do an all-nighter to get the paper in the day before the dealine" is
something that should have gone out the window after highschool. Not
for kernel development.

The rule is that things that get sent to me should be ready *before*
the merge window opens, not be made ready during the merge window.
With some slack for "life happens", of course, but I really get the
feeling that a few people treat the end of the merge window as a
deadline, missing the whole "it was supposed to be ready before the
merge window".

You know who you are.

Anyway, it's not the first time I've said this, I doubt it will be the
last. But maybe more people could take it to heart, ok?

Enough kvetching, let's get this party calmed down. The merge window
may not be the biggest ever, but it's certainly big enough that the
shortlog is much too big to post, and below is just my usual merge
log. For all the gory details, please refer to the git tree.

Please get the testing started,

                   Linus

---

Al Viro (7):
    coredump fix
    vfs inode update
    vfs d_path updates
    vfs file updates
    misc tomoyo changes
    vfs constification updates
    vfs tmpfile updates

Al Vrio (1):
    file_inode() updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Andreas Gruenbacher (2):
    gfs2 updates
    gfs2 debugfs updates

Andrew Morton (4):
    MM updates
    non-MM updates
    misc hotfixes
    more MM updates

Anna Schumaker (1):
    NFS client updates

Ard Biesheuvel (1):
    EFI updates

Arnaldo Carvalho de Melo (2):
    perf tools updates
    more perf tools updates

Arnd Bergmann (7):
    ARM defconfig updates
    ARM driver updates
    ARM devicetree updates
    ARM SoC updates
    asm-generic updates
    ARM SoC fixes
    asm-generic fix

Bartosz Golaszewski (1):
    gpio updates

Benjamin Tissoires (1):
    HID updates

Bjorn Andersson (2):
    rpmsg updates
    remoteproc updates

Bjorn Helgaas (2):
    pci updates
    pci fix

Borislav Petkov (14):
    EDAC updates
    x86 platform update
    x86 RTC cleanups
    x86 SGX update
    x86 cpu updates
    x86 RAS updates
    x86 APIC update
    x86 core fixes
    x86 asm update
    misc x86 fixes
    x86 paravirt fix
    x75 microcode loader updates
    x86 cache resource control updates
    x86 cleanups

Casey Schaufler (1):
    smack updates

Catalin Marinas (2):
    arm64 updates
    arm64 fixes

Christian Brauner (2):
    vfs acl updates
    fatfs vfsuid conversion

Christoph Hellwig (1):
    dma-mapping updates

Chuck Lever (2):
    nfsd updates
    more nfsd updates

Corey Minyard (1):
    IPMI updates

Damien Le Moal (1):
    ata updates

Dan Williams (1):
    nvdimm updates

Darrick Wong (1):
    iomap updates

Dave Airlie (3):
    drm updates
    drm fix
    more drm updates

Dave Chinner (1):
    xfs updates

Dave Hansen (1):
    x86 mm updates

David Sterba (2):
    btrfs updates
    affs update

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Dominik Brodowski (1):
    PCMCIA updates

Dominique Martinet (1):
    9p updates

Eric Biederman (4):
    kthread update
    mqueue fix
    ptrace update
    ucounts update

Eric Biggers (3):
    fscrypt updates
    fsverity updates
    STATX_DIOALIGN support

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    tty/serial driver updates
    USB / Thunderbolt updates
    driver core updates
    char/misc and other driver updates
    staging driver updates

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

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
    ceph updates

Ingo Molnar (5):
    scheduler updates
    perf events updates
    locking updates
    objtool updates
    PSI updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (2):
    networking updates
    networking fixes

James Bottomley (1):
    SCSI updates

Jan Kara (2):
    fsnotify updates
    ext2, udf, reiserfs, and quota updates

Jarkko Sakkinen (1):
    tpm updates

Jason Donenfeld (2):
    random number generator updates
    more random number generator updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jean Delvare (1):
    dmi updates

Jens Axboe (5):
    io_uring updates
    block updates
    passthrough updates
    more io_uring updates
    more block updates

Joerg Roedel (1):
    iommu updates

Jonathan Corbet (2):
    documentation updates
    documentation fixes

Juergen Gross (1):
    xen updates

Kees Cook (4):
    Rust introductory support
    execve updates
    kcfi updates
    kernel hardening updates

Lee Jones (2):
    backlight update
    MFD updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (2):
    module updates
    sysctl updates

Mark Brown (3):
    regmap updates
    regulator updates
    spi updates

Masahiro Yamada (2):
    Kbuild updates
    Kbuild fixes

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    xtensa updates

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (2):
    virtio updates
    virtio fixes

Michal Simek (1):
    microblaze updates

Micka=C3=ABl Sala=C3=BCn (1):
    landlock updates

Mike Marshall (1):
    orangefs update

Mike Rapoport (1):
    memblock updates

Mimi Zohar (1):
    integrity updates

Miquel Raynal (1):
    MTD updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Bonzini (2):
    kvm updates
    more kvm updates

Paul McKenney (3):
    nolibc updates
    LKMM (Linux Kernel Memory Model) updates
    RCU updates

Paul Moore (3):
    SELinux updates
    LSM updates
    audit updates

Pavel Machek (1):
    LED updates

Petr Mladek (2):
    printk updates
    livepatching updates

Rafael Wysocki (6):
    ACPI updates
    power management updates
    thermal control updates
    more ACPI updates
    more power management updates
    more thermal control updates

Richard Weinberger (2):
    UML updates
    UBI and UBIFS updates

Rob Herring (2):
    devicetree updates
    devicetree fixes

Russell King (2):
    ARM fixes
    ARM updates

Sebastian Reichel (2):
    HSI updates
    power supply and reset updates

Shuah Khan (4):
    Kselftest updates
    KUnit updates
    more Kselftest updates
    more KUnit updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (2):
    clk updates
    more clk updates

Steve French (3):
    ksmbd updates
    cifs updates
    more cifs updates

Steven Rostedt (2):
    tracing updates
    tracing fixes

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (1):
    cgroup updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (3):
    preempt RT updates
    timer updates
    interrupt updates

Tzung-Bi Shih (1):
    chrome platform updates

Ulf Hansson (2):
    MMC updates
    MMC fixes

Vasily Gorbik (2):
    s390 updates
    more s390 updates

Vinod Koul (3):
    dmaengine updates
    phy updates
    soundwire updates

Vlastimil Babka (2):
    slab fixes
    slab hotfix

Wei Liu (1):
    hyperv updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    more i2c updates

Yury Norov (1):
    bitmap updates
