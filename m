Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BFE5F2410
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJBQUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJBQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:20:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F063C2CC87
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 09:20:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a41so11691009edf.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=ohdqoRKNRc0sRbUk4OlFbQLSZmmj3tVcHvCkL7T1BZ0=;
        b=a1M9TQtFaOXE+T3ieYn/nhpnRA8GvZX+y8X5fKrjlrR/qPiqrRXWZgw6SAJYr2FA4X
         1GQ9LS16nAm1vvsxlijRsQg402w9nKR5e4bj3OW6tPWLQUEJd94ACeEH1CbWWLpOw6+D
         YYaWFliOFK3YoUvXEkYFCEq2QoJIxcMIpJvEci8nkbKEchqTJVgbpZo33Le0AQX8OxIA
         OMCa7Cz07dc5AKrbbDzOlx8Y165CZvJ7171MG+aL/3PhuroNqehnyPgQpulCRGXw36f6
         wGUJnz5jnALJQx8IfTMD2RShZEnAZK/URu8ZBDS4jzdIWuNWzU5mas7zu1u9FWuSjSmC
         SwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ohdqoRKNRc0sRbUk4OlFbQLSZmmj3tVcHvCkL7T1BZ0=;
        b=ycE8aeUBwxN5YBybJ0LAEpBY7GiuW59Emr14a4SYFhZ0Ai9pAyhCbsU93Wi2bV8JSk
         I4/1quAetw5s75SspUbFkqjoSQNhKns/NRwroHoDLx88cW0WNSwK4PrYw4cCqa1Vb5It
         BwNa060vqz+N5OROiAtoLkUcGZ3/+HHJqecRv9CsA7jkSZwG1uAPzZBQt7B73gwY+fJC
         +DzdiSxguczxxzHQO+YZrW+Md05WX+yVMAYahjFUhNENfW/VKWa6OUlU5myfmWFVq6Ap
         kPj9l5435aPvlAyy0zqMEOPYyfyxXshDbsfPi42rpWSgBG9Hez0ybmOrtsa/ftxNQcne
         OUNw==
X-Gm-Message-State: ACrzQf21p6QMFFg7osouQqqk+78edxjPKuyK7iWvEdHABclekT2tbAQr
        209O6tm1lbxLTRZ/clzc8nDxKfc1NVu82Q==
X-Google-Smtp-Source: AMsMyM4IzXOAo788h7Mjx6klXNVbaUtTci/LAdV5IYRF8ulqc8nnJsrt9psuxEGiYi8LAZry0yF6MA==
X-Received: by 2002:a05:6402:550c:b0:443:7d15:d57f with SMTP id fi12-20020a056402550c00b004437d15d57fmr15495137edb.147.1664727643401;
        Sun, 02 Oct 2022 09:20:43 -0700 (PDT)
Received: from mbp-di-paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906301100b00731582babcasm4184198ejz.71.2022.10.02.09.20.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Oct 2022 09:20:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: block: wrong return value by bio_end_sector?
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <8d5ffebe-39dc-b811-ce7c-9df4b5d061c1@opensource.wdc.com>
Date:   Sun, 2 Oct 2022 18:20:41 +0200
Cc:     Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <51C3A1EA-A746-4DA2-AFC1-D9C4C1D7B213@linaro.org>
References: <D4FC5552-B3C8-4118-B3C8-C6BF20C793B4@linaro.org>
 <8d5ffebe-39dc-b811-ce7c-9df4b5d061c1@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 1 ott 2022, alle ore 02:50, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20
> On 10/1/22 00:59, Paolo Valente wrote:
>> Hi Jens, Damien, all other possibly interested people, this is to =
raise
>> attention on a mistake that has emerged in a thread on a bfq =
extension
>> for multi-actuary drives [1].
>>=20
>> The mistake is apparently in the macro bio_end_sector (defined in=20
>> include/linux/bio.h), which seems to be translated (incorrectly) as=20=

>> sector+size, and not as sector+size-1.
>=20
> This has been like this for a long time, I think.
>=20
>>=20
>> For your convenience, I'm pasting a detailed description of the=20
>> problem, by Tyler (description taken from the above thread [1]).
>>=20
>> The drive reports the actuator ranges as a starting LBA and a count =
of
>> LBAs for the range. If the code reading the reported values simply =
does
>> startingLBA + range, this is an incorrect ending LBA for that =
actuator.
>=20
> Well, yes. LBA 0 + drive capacity is also an incorrect LBA. If the =
code
> assumes that it is, you have a classic off-by-one bug.
>=20
>> This is because LBAs are zero indexed and this simple addition is not
>> taking that into account. The proper way to get the endingLBA is
>> startingLBA + range - 1 to get the last LBA value for where to issue =
a
>> final IO read/write to account for LBA values starting at zero rather
>> than one.
>=20
> Yes. And ? Where is the issue ?
>=20
>>=20
>> Here is an example from the output in SeaChest/openSeaChest:=20
>> =3D=3D=3D=3DConcurrent Positioning Ranges=3D=3D=3D=3D
>>=20
>> Range#     #Elements            Lowest LBA          # of LBAs 0
>> 1                                               0
>> 17578328064 1            1                         17578328064
>> 17578328064
>>=20
>> If using the incorrect formula to get the final LBA for actuator 0, =
you
>> would get 17578328064, but this is the starting LBA reported by the
>> drive for actuator 1. So to be consistent for all ranges, the final =
LBA
>> for a given actuator should be calculated as starting LBA + range - =
1.
>>=20
>> I had reached out to Seagate's T10 and T13 representatives for
>> clarification and verification and this is most likely what is =
causing
>> the error is a missing - 1 somewhere after getting the information
>> reported by the device. They agreed that the reporting from the drive
>> and the SCSI to ATA translation is correct.
>>=20
>> I'm not sure where this is being read and calculated, but it is not =
an
>> error in the low-level libata or sd level of the kernel. It may be in
>> bfq, or it may be in some other place after the sd layer. I know =
there
>> were some additions to read this and report it up the stack, but I =
did
>> not think those were wrong as they seemed to pass the drive reported
>> information up the stack.
>>=20
>> Jens, Damien, can you shed a light on this?
>=20
> I am not clear on what the problem is exactly. This all sound like a
> simple off-by-one issue if bfq support code. No ?

Yes, it's (also) in bfq code now; no, it's not only in bfq code.=20

The involved bfq code is a replica of the following original function
(living in block/blk-iaranges.c):

static struct blk_independent_access_range *
disk_find_ia_range(struct blk_independent_access_ranges *iars,
		  sector_t sector)
{
	struct blk_independent_access_range *iar;
	int i;

	for (i =3D 0; i < iars->nr_ia_ranges; i++) {
		iar =3D &iars->ia_range[i];
		if (sector >=3D iar->sector &&
		    sector < iar->sector + iar->nr_sectors)
			return iar;
	}

	return NULL;
}

bfq's replica simply contains also this warning, right before the return =
NULL:

	WARN_ONCE(true,
		  "bfq_actuator_index: bio sector out of ranges: =
end=3D%llu\n",
		  end);

So, if this warning is triggered, then the sector does not belong to
any range.

That warning gets actually triggered [1], for a sector number that is
larger than the largest extreme (iar->sector + iar->nr_sectors) in the
iar data structure.  The offending value resulted to be simply equal
to the largest possible value accepted by the iar data structure, plus
one.

So, yes, this is an off-by-one error.  More precisely, there is a
mismatch between the above code (or the values stored the iar data
structure) and the value of bio_end_sector (the latter is passed as
input to the above function).  bio_end_sector does not seem to give
the end sector of a request (equal to begin+size-1), as apparently
expected by the above code, but the sector after the last one (namely,
begin+size).

Should I express an opinion on where the error is, I would say that
the mistake is in bio_end_sector.  But I could be totally wrong, as
I'm not a expert of either of the involved parts.  In addition,
bio_end_sector is already in use, with its current formula, by other
parts of the block layer.  If you guys (Damien, Jens, Tyler?, ...)
give us some guidance on what to fix exactly, we will be happy to make
a fix.

Thanks,
Paolo



>=20
>>=20
>> Thanks, Paolo
>>=20
>> [1] https://www.spinics.net/lists/kernel/msg4507408.html
>=20
> --=20
> Damien Le Moal
> Western Digital Research

