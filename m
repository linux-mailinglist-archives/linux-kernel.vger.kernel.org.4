Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9777A6E15CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 22:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjDMUYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 16:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjDMUYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:24:51 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078029038
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:24:45 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 338D63F433
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 20:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681417483;
        bh=PQq+mz7dR9QT7iHE9yvRNq40ih9JKo4aO04MKlknKpw=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=SfwzuqGrTTpxiV0QxZUlX19C/hEqvYyKnQCjIx1TAtjCzcNxWr8TKsV3fwyEiYWgg
         3R0Dov9QPe5KZvh2NTFOhoj4qdsZnCGkVfAFjiMcjftncE7o0LY33+af2iRfZLzf0h
         +HbYWt0jH/FzMgnDlTZ+fthy/DV4C+YuFWw5lsAZhEA3HqHYyiIEoxvA0ZfX/DgX0v
         qWoOJJFv5oC/PUxH2gG80D4Hax/7fHePFuNrpjJep1O/ii16QQD7jotJB5v+vmlzj6
         494lBjLgh39MAGPS0QSBPr8t69PIuwlbXi4WhVN7XNEaJ0RN1rwnKoPyAxeNR4C+j5
         zthg4e0KYkw4Q==
Received: by mail-wr1-f71.google.com with SMTP id t30-20020adfa2de000000b002f575ad4a7cso861292wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681417480; x=1684009480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQq+mz7dR9QT7iHE9yvRNq40ih9JKo4aO04MKlknKpw=;
        b=iRJ+27/EK94ijFP11qGZJj/HqPpc6Gn5YGLdY6ppceTdjR2WT/d/tj90yj3Fxv9Qz7
         HUEuLZVzGfkw8i5rL6TKr7EK+BOlG2Jrhqk8I2HODzzdno8pXUeFN8KECh6fmJke1Ix9
         cHw4lfmkCVW8bTduLo22fMN4GrES6A6m//GTzYbqmoR6E1wCCukXXIphRjMRyHAAMu63
         iea5tM6lqyqwWIayVLAyvMxi5Dk4NSW5t7O7i/erSlIyGc5iLxQbOgupfPWUoW3mb86V
         wP0/5SY3/Y0ZeEGsycFbgmSbc8CJbS/zhVpZOREkRhSRNgVW/eN6/QoMzMLpqdrXVI8A
         Ngzw==
X-Gm-Message-State: AAQBX9dc3DNajbp5vmuE/UXoTBC3JYwT6eSOM8yJdt4AIHBtkcIXVXLV
        fPMQcbru8UuMve3lIqVzjgjL/Vhd+VBCjLVXirKLWyEBGEbVIA5456lZmDihuh9lMHVL3PlrT/H
        7i1DVtgLvxDQDXTuzMphxZAfTeriSAZqS0FhLM6zLwA==
X-Received: by 2002:adf:cf08:0:b0:2f5:3dfd:f4d4 with SMTP id o8-20020adfcf08000000b002f53dfdf4d4mr2071349wrj.62.1681417479933;
        Thu, 13 Apr 2023 13:24:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zdn7VEWjgL3YS9IZneemymvD7mh4MQ2zK5BN0i72TBG1rL1bn4ZXlcA+x4h2NjUz+QY6JLQw==
X-Received: by 2002:adf:cf08:0:b0:2f5:3dfd:f4d4 with SMTP id o8-20020adfcf08000000b002f53dfdf4d4mr2071338wrj.62.1681417479568;
        Thu, 13 Apr 2023 13:24:39 -0700 (PDT)
Received: from localhost (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id u4-20020adfed44000000b002e5f3d81c06sm1971145wro.89.2023.04.13.13.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 13:24:39 -0700 (PDT)
Date:   Thu, 13 Apr 2023 22:24:38 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Darren Hart <darren@os.amperecomputing.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZDhlBjbRGufpDm6u@righiandr-XPS-13-7390>
References: <CAMj1kXES+FxxbqUPH5TRjHak2MMC2Yksm0_P6wo__LQMH6Emhw@mail.gmail.com>
 <ZBMes6r2FiAyo81F@righiandr-XPS-13-7390>
 <CAMj1kXG0+NO6HayK2YqSJU0pwj8bn9Un_G-4VJr=hc1ELi-TpQ@mail.gmail.com>
 <ZBMgy+Yh9fDxt44C@righiandr-XPS-13-7390>
 <CAMj1kXEWs43NaTegzmGPFD7UGNVw_13hUCuvmwvKNVYPsfh5Vg@mail.gmail.com>
 <CAMj1kXHKkK+6TDLebZw=H-ZZLVnwPGSRpNNKSbJoPwwA2vhG+w@mail.gmail.com>
 <ZBNXaF32nIh3Ca49@righiandr-XPS-13-7390>
 <CAMj1kXFgmPp8TPDWePNN2wU_TQ87dL940SFEaMKAm4oVaB86+g@mail.gmail.com>
 <ZBOYBdJR00dOKPSx@fedora>
 <CAMj1kXF8G3G41cPt+5=nB2D_uEaB_iXh6=3ZcTFTHrpsVm5D5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF8G3G41cPt+5=nB2D_uEaB_iXh6=3ZcTFTHrpsVm5D5g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 11:35:44AM +0100, Ard Biesheuvel wrote:
> On Thu, 16 Mar 2023 at 23:28, Darren Hart <darren@os.amperecomputing.com> wrote:
> >
> > On Thu, Mar 16, 2023 at 07:55:36PM +0100, Ard Biesheuvel wrote:
> > > On Thu, 16 Mar 2023 at 18:52, Andrea Righi <andrea.righi@canonical.com> wrote:
> ...
> > > >
> > > > Yay! Success! I just tested your latest efi/urgent (with the fixup) and
> > > > system completed the boot without any soft lockups.
> > > >
> > >
> > > Thanks for confirming. I'll take that as a tested-by
> >
> > The solution in the current branch looks like the best approach we have to date
> > to address the broadest of affected systems. We could switch the eMAG test to an
> > MIDR test I believe (but this won't work for Altra as that would capture all the
> > Neoverse v1 cores beyond Altra). I can look into the MIDR test if you think it's
> > worthwhile - but since I don't think we can eliminate the SMBIOS string test, it
> > doesn't buy us much since we don't need a greedier eMAG test (there aren't more
> > of them to match).
> >
> > Given that some OEM Altra platforms change the processor ID, I don't see a
> > better solution currently than adding their the "product name" to the smbios
> > string tests unfortunately.
> >
> 
> Indeed. I spotted a Gigabyte system [0] with a different processor ID,
> but with a version we can test for.
> 
> So for now, I'll go with
> 
>         socid = (u32 *)record->processor_id;
>         switch (*socid & 0xffff000f) {
>                 static char const altra[] = "Ampere(TM) Altra(TM) Processor";
>                 static char const emag[] = "eMAG";
>         default:
>                 version = efi_get_smbios_string(&record->header, 4,
>                                                 processor_version);
>                 if (!version || (strncmp(version, altra, sizeof(altra) - 1) &&
>                                  strncmp(version, emag, sizeof(emag) - 1)))
>                         break;
> 
>                 fallthrough;
> 
>         case 0x0a160001:        // Altra
>         case 0x0a160002:        // Altra Max
>                 efi_warn("Working around broken SetVirtualAddressMap()\n");
> ...
> 
> which should cover all the affected systems we encountered so far.
> 
> I'll push this to linux-next to let it soak for a little bit, and then
> send it to Linus somewhere during the week
> 
> Thanks,
> Ard.
> 
> 
> [0] https://pastebin.com/HQLE1yYv

Not sure if it's a similar issue, but I have found another Ampere box
that is booting fine with your fixes, but the eifvars.sh kselftest is
failing with some I/O errors, specifically:

$ sudo ./efivarfs.sh
--------------------
running test_create
--------------------
./efivarfs.sh: line 58: printf: write error: Input/output error
/sys/firmware/efi/efivars/test_create-210be57c-9849-4fc7-a635-e6382d1aec27 has invalid size
  [FAIL]
--------------------
running test_create_empty
--------------------
  [PASS]
--------------------
running test_create_read
--------------------
  [PASS]
--------------------
running test_delete
--------------------
./efivarfs.sh: line 103: printf: write error: Input/output error
  [PASS]
--------------------
running test_zero_size_delete
--------------------
./efivarfs.sh: line 126: printf: write error: Input/output error
./efivarfs.sh: line 134: printf: write error: Input/output error
/sys/firmware/efi/efivars/test_zero_size_delete-210be57c-9849-4fc7-a635-e6382d1aec27 should have been deleted
  [FAIL]
--------------------
running test_open_unlink
--------------------
open(O_WRONLY): Operation not permitted
  [FAIL]
--------------------
running test_valid_filenames
--------------------
./efivarfs.sh: line 158: printf: write error: Input/output error
./efivarfs.sh: line 158: printf: write error: Input/output error
./efivarfs.sh: line 158: printf: write error: Input/output error
./efivarfs.sh: line 158: printf: write error: Input/output error
  [PASS]
--------------------
running test_invalid_filenames
--------------------
  [PASS]

If it helps:

$ sudo hexdump -C /sys/firmware/dmi/entries/4-0/raw
00000000  04 30 04 00 01 03 fe 02  c1 d0 3f 41 00 00 00 00  |.0........?A....|
00000010  03 8a 72 06 b8 0b f0 0a  41 06 05 00 06 00 07 00  |..r.....A.......|
00000020  04 05 06 50 50 50 04 00  01 01 01 00 01 00 01 00  |...PPP..........|
00000030  43 50 55 20 31 00 41 6d  70 65 72 65 28 52 29 00  |CPU 1.Ampere(R).|
00000040  41 6d 70 65 72 65 28 52  29 20 41 6c 74 72 61 28  |Ampere(R) Altra(|
00000050  52 29 20 50 72 6f 63 65  73 73 6f 72 00 30 30 30  |R) Processor.000|
00000060  30 30 30 30 30 30 30 30  30 30 30 30 30 30 32 35  |0000000000000025|
00000070  35 30 32 30 39 30 33 33  38 36 35 42 34 00 30 30  |50209033865B4.00|
00000080  30 30 30 30 30 31 00 51  38 30 2d 33 30 00 00     |000001.Q80-30..|
0000008f

I guess EFI is not very reliable here...

-Andrea
