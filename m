Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7D6F9BC0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjEGVSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjEGVSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:18:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82D1989
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 14:18:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so7498523a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683494321; x=1686086321;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iKN3GJhn8Ks559hpfdHcJljrnu4TUiorXS09CsZ3ZLI=;
        b=FAkiOz32gIOIP4VzD0AQYPoF7NvDSOHWlRvE44lG4XtVyhSVcH6QmjYr/OlqEOxFf1
         WUoD0sLEQRdeoBEHhlarXXxpY7YQPA4RY5XnCWBT+vsQYc+dhT/7Gl1EomRt0Us64jHa
         ZQjmkBrfuJI3wkk2+V5b65W+HPLzSHTmbYvJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683494321; x=1686086321;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKN3GJhn8Ks559hpfdHcJljrnu4TUiorXS09CsZ3ZLI=;
        b=HBbNSIl2xC1ZnAvII3BT/d9JdQ2Ic4N7uTDzY0DhRPOLdTDzB/QPebUDifUyrikrsa
         Zot71img4rBDYPk75cEAmz6SSUrMb+baFiA7IzNObLnEi4hSORLaWPTBn4KZFnb1AgVB
         nuo0nI8F4oD59gsqTq7hSy82z3vo3hQvOM/XpCIUQheFQicpT9GxXnMXSWcwQK9doO0C
         jGq7EfbI6gqXIkaewtNm2tuHXYuHtljlgZlFz3pihcbOyldrOoK4Sl7Mx6gFJQUQ4sbm
         rO/miX+swpdRr6ZksNy4+6BQwUefbmN8yQNTx+09a4Sak6jsPw6bmyk1QmlPAgPD8xvi
         u7IQ==
X-Gm-Message-State: AC+VfDxi+lToLClKH5r4X0qCG1DeiFrSWvR27oXQMPmFegjyWQg+3Afn
        obhrjKgs0VLmWwPBmq1koKTNeMPzVRgvh+MOnZFV2w==
X-Google-Smtp-Source: ACHHUZ5CZOG3K1KPACcFv1nbcAwco/ZpUsUPo+nY9HrviUJUmXVumk1gjH2q7IW1e09oyS7A4AnFLg==
X-Received: by 2002:a17:907:a408:b0:94e:5780:23f9 with SMTP id sg8-20020a170907a40800b0094e578023f9mr7468415ejc.48.1683494320865;
        Sun, 07 May 2023 14:18:40 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id b13-20020a1709063f8d00b0094f410225c7sm4019897ejj.169.2023.05.07.14.18.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 14:18:40 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-959a3e2dd27so676607566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 14:18:39 -0700 (PDT)
X-Received: by 2002:a17:907:720f:b0:95f:4c5c:4eaf with SMTP id
 dr15-20020a170907720f00b0095f4c5c4eafmr6756247ejc.46.1683494319584; Sun, 07
 May 2023 14:18:39 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 May 2023 14:18:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com>
Message-ID: <CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com>
Subject: Linux 6.4-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So here we are, two weeks later, with the merge window over, and -rc1
tagged and pushed out.

Things look pretty normal - the only somewhat unusual thing for me
personally was that we had two different pull requests that ended up
with me doing my own little series of updates on top.

So both the ITER_UBUF update from Jens, and the x86 LAM support from
Dave Hansen (really Kirill, but I see the pull from Dave) caused me to
do some extra x86 user access cleanups.

The reason I mention that isn't so much "oh, I got to code a bit
again", but that this actually caused me to *finally* switch to a more
modern default 'git diff' algorithm. The default git diff algorithm is
the very traditional one (aka 'Myers algorithm'), and while it works
just fine, there's been various heuristics updates to make for nicer
diffs by default.

So I'm now using the 'histogram' algorithm, that takes the
"uniqueness" of a line into account when deciding on longest common
subsequence, because some of my patches were just an unreadable mess
with the plain Myers diff.  Not that histogram always helps, but it
does often make things more legible.

Now, this shouldn't really impact anybody else, and I know some people
were already using either the patience of histogram algorithms, but I
mention it because it does occasionally cause line number differences
in the diffstats, and thus affects the pull-request output.

I'm already used to small differences, but *if* you send me pull
requests, this does mean that it might be just slightly easier on me
if you follow my lead on picking a diff algorithm, and do

     git config diff.algorithm histogram

in your kernel tree. Or, if you find that you prefer it over-all,
maybe add "--global" there to do it in your main gitconfig to affect
all your trees.

[ Or just edit your .gitconfig files manually, it's actually what I
do, but when telling others "you might want to do this", it's simpler
to just give the "git config" command line ]

Anyway, this is absolutely *not* a requirement, and honestly, in 95%
of all cases it probably won't even change the diff output at all. But
I thought I might just mention it to make people aware (and to maybe
minimize the number of pull requests where I go "ok, let's figure out
why my end result isn't exactly the same as the one in the PR").

As to the actual changes in this merge window: the mergelog below
gives the high-level view. The diffstat is completely dominated by AMD
GPU hardware description files once again, and this time the 'perf'
tool has followed suite, and so the other big area ends up being all
the perf event JSON file descriptions. Ugh.

But if you ignore those two "massive, but uninteresting" parts of the
changes, everything else looks fairly normal. Lots of development all
over, with "that's interesting" mainly depending on the reader.
Drivers, architecture updates, filesystems, networking, memory
management - there's a bit of everything.

The one feature that didn't make it was the x86 shadow stack code.
That side was probably a bit unlucky, in that it came in as I was
looking at x86 issues anyway, and so I looked at it quite a bit, and
had enough reservations that I asked for a couple of fairly big
re-organizations.

We'll get to that at a later date, possibly the next release.

Anyway, please do go test it all out,

            Linus

---

Al Viro (5):
    vfs fget updates
    vfs write_one_page removal
    legacy dio cleanup
    misc vfs pile
    trivial nios2 cleanup

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (6):
    MM updates
    non-MM updates
    more MM updates
    hotfixes
    dmapool updates - again

Anna Schumaker (1):
    NFS client updates

Ard Biesheuvel (1):
    EFI updates

Arnaldo Carvalho de Melo (1):
    perf tool updates

Arnd Bergmann (5):
    ARM SoC updates
    ARM SoC driver updates
    ARM SoC defconfig updates
    ARM SoC devicetree updates
    asm-generic updates

Bartosz Golaszewski (1):
    gpio updates

Bjorn Andersson (2):
    rpmsg updates
    remoteproc updates

Bjorn Helgaas (1):
    pci updates

Borislav Petkov (8):
    EDAC updates
    RAS updates
    x86 ACPI update
    x86 cpu model updates
    misc x86 updates
    x86 paravirt updates
    x86 SEV updates
    x86 cleanups

Casey Schaufler (1):
    smack updates

Christian Brauner (6):
    clone3 selftest fix
    user work thread updates
    pidfd updates
    acl updates
    misc vfs updates
    vfs open fixlet

Christoph Hellwig (1):
    dma-mapping updates

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    IPMI updates

Damien Le Moal (1):
    ata updates

Dan Williams (1):
    compute express link updates

Darrick Wong (1):
    iomap updates

Dave Airlie (3):
    drm updates
    drm fixes
    more drm fixes

Dave Chinner (1):
    xfs updates

Dave Hansen (4):
    x86 resctrl update
    x86 fpu updates
    x86 tdx update
    x86 LAM (Linear Address Masking) support

David Howells (1):
    AFS updates

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Dipen Patel (1):
    hardware timestamp engine updates

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

Greg KH (5):
    USB / Thunderbolt updates
    tty / serial updates
    staging driver updates
    driver core updates
    char/misc drivers updates

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

Guo Ren (1):
    arch/csky updates

Gustavo Silva (1):
    flexible-array updates

Hans de Goede (1):
    x86 platform driver updates

Helge Deller (2):
    fbdev updates
    parisc updates

Herbert Xu (2):
    crypto updates
    crypto fixes

Huacai Chen (1):
    LoongArch updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (5):
    objtool updates
    perf updates
    scheduler updates
    SMP cross-CPU function-call updates
    locking updates

Jaegeuk Kim (1):
    f2fs update

Jakub Kicinski (1):
    networking fixes

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (1):
    ext2, reiserfs, udf, and quota updates

Jarkko Sakkinen (2):
    tpm updates
    tpm fix

Jason Gunthorpe (2):
    iommufd updates
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (6):
    ITER_UBUF updates
    io_uring updates
    block updates
    nonblocking pipe io_uring support
    more block updates
    more io_uring updates

Jiri Kosina (1):
    HID updates

Joel Fernandes (1):
    RCU updates

Joerg Roedel (1):
    iommu updates

John Paul Adrian Glaubitz (1):
    sh updates

Jonathan Corbet (2):
    documentation updates
    more documentation updates

Juergen Gross (1):
    xen updates

Kees Cook (2):
    hardening update
    pstore update

Konstantin Komarov (1):
    ntfs3 updates

Lee Jones (3):
    LED updates
    MFD updates
    backlight updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (4):
    module updates
    sysctl updates
    more sysctl updates
    modules fix

Mark Brown (4):
    regmap updates
    regulator updates
    spi updates
    regulator fix

Masahiro Yamada (1):
    Kbuild updates

Mauro Carvalho Chehab (1):
    media updates

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Micka=C3=ABl Sala=C3=BCn (1):
    landlock update

Miguel Ojeda (1):
    rust updates

Mike Snitzer (1):
    device mapper updates

Mimi Zohar (1):
    integrity update

Miquel Raynal (1):
    mtd updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Abeni (1):
    networking updates

Paolo Bonzini (2):
    kvm updates
    more kvm updates

Paul McKenney (5):
    KCSAN updates
    Linux Kernel Memory Model scripting updates
    locktorture updates
    nolibc updates
    Linux Kernel Memory Model updates

Paul Moore (3):
    selinux updates
    lsm updates
    lsm fix

Petr Mladek (2):
    printk updates
    livepatching updates

Rafael Wysocki (8):
    thermal control updates
    ACPI updates
    power management updates
    more thermal control updates
    more ACPI updates
    more power management updates
    thermal control fixes
    ACPI fix

Richard Weinberger (2):
    UBI and UBIFS updates
    uml updates

Rob Herring (3):
    devicetree updates
    more devicetree updates
    devicetree fixes

Russell King (1):
    ARM development updates

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (2):
    Kselftest updates
    KUnit updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (2):
    clk updates
    clk fixes

Steve French (4):
    ksmbd server updates
    cifs fixes
    ksmbd server fixes
    cifs fixes

Steven Rostedt (3):
    tracing updates
    tracing tools updates
    more tracing updates

Takashi Iwai (2):
    sound updates
    sound fixes

Takashi Sakamoto (1):
    firewire updates

Ted Ts'o (2):
    ext4 updates
    ext4 fixes

Tejun Heo (2):
    workqueue updates
    cgroup updates

Tetsuo Handa (1):
    tomoyo update

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (7):
    core debugobjects update
    core entry/ptrace update
    interrupt updates
    timers and timekeeping updates
    x86 APIC updates
    more timer updates
    debugobjects fix

Tzung-Bi Shih (1):
    chrome platform updates

Ulf Hansson (1):
    MMC updates

Vasily Gorbik (1):
    s390 updates

Vinod Koul (4):
    dmaengine updates
    phy updates
    soundwire updates
    phy fixes

Vlastimil Babka (1):
    slab updates

Wei Liu (1):
    hyperv updates

Will Deacon (2):
    arm64 updates
    arm64 fixes

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    more i2c updates
