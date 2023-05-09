Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE19C6FCCA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjEIRYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjEIRYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:24:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240930F3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:24:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4eff50911bfso6813148e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683653074; x=1686245074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KijSDDtr4Rt22dcRS8vqEW+f0ADU373p/rgXdIi8mN8=;
        b=oANRBLfG4slWbvN06gbXaSs+bG+dC/JrCD+T1ZYmrYEIhCJVH5eZTxcfi+4v70joJ3
         vs99RlmBGYV2tSB5czl04bPsJAjNlHR65WlIApWKY7sp07ad1j91IA4yifWUj7li17Ev
         PChbV3tuKGhx0SWW+MeZZ/mk7eMfHezw/1KOrElcG4af7QSLhmwA24imVYfu+G9jJz3g
         9KAEkW8eYZ8FIj5X9mDZu9d9WR7TjccylasEID9YFz9eMY95Y+zCmYk3l+Eey4EETvi4
         EBTRwCklUE//bSYIlqtbcuk6aMX5j8x35v6INdvfEElNRNYVP3ZU1PTNqNcVvfXQMMGz
         matA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683653074; x=1686245074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KijSDDtr4Rt22dcRS8vqEW+f0ADU373p/rgXdIi8mN8=;
        b=YhVHs8rjbCeKC/wJaGdL5MHUQPdhjcvjqxaAepwIBobxO9VTTt9QSv+d2qMruvq91G
         Llq6QqjF5c9DsRLqpm/1fH6lxwM/WdmS/wWMXuJgzHoPn1nNywHbrJIwuSLhd1zD9O3q
         UDrKl+9CrwQ3WaE5dP7Qu/Ht9NxcYyf9vUky1CZuAtY/sAcS6qZWveAu5l0yvhqPgILw
         y7PrFFGD8W94lf6Raz0twArVqVDEk/3/uAlcTw9pNHxp7vxJ7G60mq2fNxI709J6nXO1
         ELFNJ1I5u985ZyVF8JuhJs4dxuoIzZIhancGGL4FzM0tYOnPEbEN6IUFtIBMWga7Kp9p
         QzdA==
X-Gm-Message-State: AC+VfDw4T5i/GoAtqJ3Dp22EknQVLJrXgGMdeNBX59B02S6S60OtQbrV
        Lk4OLUvZj3/0bdMgfyO1H5/pw5wxpfpjE8D4+PCl/ce5HKt6Y4by
X-Google-Smtp-Source: ACHHUZ5goDi9spAV+VnvFQcUsJdDpeKQoLmuh1K1IhnRnNXbQC8fPc2AxH/LXD+LwOZZUrtwuooBVHIk73NWlIZeypQ=
X-Received: by 2002:ac2:5293:0:b0:4eb:42b7:8c18 with SMTP id
 q19-20020ac25293000000b004eb42b78c18mr1021784lfm.53.1683653073672; Tue, 09
 May 2023 10:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-4b9e3d86-2f0b-47da-8a5d-bd383a0171d6@palmer-ri-x1c9>
 <4830085.8hb0ThOEGa@diego> <CALs-HsveK-uUuSAOkUUPuUYK6_ChG95_YWtdwYvGsTfKYSWUpg@mail.gmail.com>
 <CAAeLtUDgWwT0wxhFANagBX4ExA_HkyqM-ZdPn==+_atGV3vTww@mail.gmail.com>
In-Reply-To: <CAAeLtUDgWwT0wxhFANagBX4ExA_HkyqM-ZdPn==+_atGV3vTww@mail.gmail.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 9 May 2023 10:23:57 -0700
Message-ID: <CALs-HsvvUsqW6zib2oqfnJ-ddND6dK3ow_O5LG46Rc61iGVMmA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux vector
To:     Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>, bjorn@kernel.org,
        jrtc27@jrtc27.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        kito.cheng@sifive.com, Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com, heinrich.schuchardt@canonical.com,
        greentime.hu@sifive.com, nick.knight@sifive.com,
        christoph.muellner@vrull.eu,
        Richard Henderson <richard.henderson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 10:33=E2=80=AFAM Philipp Tomsich
<philipp.tomsich@vrull.eu> wrote:
>
> Evan,
>
> On Mon, 8 May 2023 at 18:50, Evan Green <evan@rivosinc.com> wrote:
>>
>> On Wed, May 3, 2023 at 3:31=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.=
de> wrote:
>> >
>> > Hi,
>> >
>> > Am Dienstag, 2. Mai 2023, 19:15:29 CEST schrieb Palmer Dabbelt:
>> > > On Tue, 02 May 2023 02:13:10 PDT (-0700), philipp.tomsich@vrull.eu w=
rote:
>> > > > On Tue, 2 May 2023 at 09:58, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.o=
rg> wrote:
>> > > >>
>> > > >> Philipp Tomsich <philipp.tomsich@vrull.eu> writes:
>> > > >>
>> > > >> > It is a pity that the current interface was designed without in=
volving
>> > > >> > RVI (and that I had to ask my team to put together a patch set =
for
>> > > >> > further discussion, given that none of the other major vendors =
in RVI
>> > > >> > stepped forward).  I guarantee that plenty of reviewers would h=
ave
>> > > >> > highlighted that a central registry (even if it is just a kerne=
l
>> > > >> > header) should be avoided.
>> > > >>
>> > > >> Are you claiming that the hwprobe work was not done in the open, =
but
>> > > >> secretly merged? That is not only incorrect, but rude to upstream=
 RISC-V
>> > > >> Linux developers. I suggest you review how you interact with upst=
ream
>> > > >> kernel work.
>> > > >
>> > > > Please don't put words into my mouth...
>> > > >
>> > > > I was merely pointing out that there was no engagement by the RVI
>> > > > member companies (in regard to this mechanism) within RVI, which w=
ould
>> > > > have prevented Jessica's issue.
>> > > > This would have also helped to address the concerns on vendor-defi=
ned
>> > > > extensions.
>> > > >
>> > > > Also who do you refer to when you say "how _you_ interact"?  If it=
 is
>> > > > RVI that you refer to: it doesn't interact with upstream work
>> > > > directly, as it doesn't own any engineering resources.
>> > > > RVI provides a forum for member companies to come to an
>> > > > understanding/design and then have the member companies perform th=
e
>> > > > work and take it upstream.
>> > >
>> > > I'm not even sure what you're looking for here: if RVI doesn't want =
to
>> > > work upstream, then complaining that RVI isn't part of upstream
>> > > discussions is pretty pointless.
>> > >
>> > > >> Why didn't RVI get involved in the review of the series? The expe=
ctation
>> > > >> cannot be that all open source projects go to RVI, but rather the=
 other
>> > > >> way around.
>> > > >
>> > > > That is exactly the point I was making and which you seem to miss:=
 RVI
>> > > > does not own any engineering resources and depends solely on its
>> > > > member companies to project into open source projects.
>> > > >
>> > > >> Take a look at commit ea3de9ce8aa2 ("RISC-V: Add a syscall for HW
>> > > >> probing"). Your team was very much involved in the review.
>> > > >
>> > > > I am aware, as I had reviewed and commented on these are well.
>> > > > And my only request (was and) is that we need to figure out a way =
to
>> > > > efficiently deal with vendor-defined extensions.
>> > >
>> > > Maybe you should go talk to you team, then?  Handling vendor extensi=
ons
>> > > via hwprobe has been discussed, sounds like you're confused again.
>> >
>> > I too have this vague memory of us talking about vendor extensions,
>> > but my memory is really bad for stuff like this, so I spent the mornin=
g
>> > combing through all the hwprobe iterations looking for it, but so far
>> > have only found
>> >
>> > https://lore.kernel.org/lkml/CALs-HstoeoTWjTEZrLWouCgwq0t3tDB6uL=3DtB6=
8RJDs1ub4Frw@mail.gmail.com/
>> >
>> > I'm most likely just blind, but does someone have another pointer?
>>
>> Hello! That's probably the only pointer.
>
>
> Thanks for following up, as we were debating internally if and what discu=
ssions we had missed.
>
>>
>> Couldn't handling vendor extensions within the hwprobe framework be as
>> straightforward as explicitly carving out a region for them? Say
>> 0x8000000000000000+ belongs to the vendor? The layout of keys within
>> the vendor hwprobe region then depends on the value in mvendorid (and
>> if the vendor so chooses, archid and impid as well). Then vendors can
>> expose keys to their hearts (avoiding the dumb pun there) content.
>>
>> We can probably skip caching the vendor keys in the vDSO for now. If
>> it really needs to be done we can add it later.
>>
>> This would enforce that there's only one "vendor" at a time for a
>> given hart, but I think that's reasonable. Let me know what you think.
>
>
> We generally try to treat vendor-extensions as "vendor-defined" and not "=
vendor-specific".  In other words, an implementor would be free to implemen=
t XVentanaCondOp and XTHeadVDot.  While we could simply alias things into t=
he implementor's "vendor"-space, I see some benefits to having a unique id =
for every vendor-defined property=E2=80=A6
>
> Could we use ( 0x8000000000000000 | vendor-id << VENDOR_SHIFT | key-in-ve=
ndor-space )?
> If so, do we have vendor-ids allocated today that we could use for this p=
urpose?

I can sort of see why you'd make that choice architecturally, and the
translation of that idea to this implementation is reasonable. But I
think there are too many dragons there for not enough benefit. Some
thoughts below:

 * I'm a little skeptical of the idea that vendors will actually
implement each other's extensions. Have there been a lot of instances
of this so far we can point to? However, even if they did, I think the
chances that they'll do it identically, such that software can simply
look at the feature bit without also considering the vendor, are
virtually nil. So doing all of these acrobatics to allow usermode to
query a single bit are pointless if the implementations come out
different (or even might come out different) and a (correctly)
defensive usermode filters it by mvendorid anyway.

 * Outside of parsing the ISA string, there's no sane implementation
for a vendor to populate/probe their vendor-specific feature set on
another vendor's hardware. So all the implementations are going to
start with if (mvendorid !=3D mine) return -1, which again makes
exposing all vendors keys on all chips a bit silly.

 * If we did have that rare vendor extension that the vendors all
loved and implemented perfectly faithfully, it would be easy enough to
lower it into the general hwprobe keyspace. I think this will be rare
enough that we won't be tripping over our own merge conflicts.

 * As others have documented, there are real downsides to slicing up
the keyspace this finely: we'd be imposing lower ceilings on the
number of vendors and the number of keys per vendor, and we now have
to become the arbiter of a vendor ID to enum mapping. And since this
is ABI, once that keyspace is allocated to some vendor, it's gone
forever.

One thing we could do if we're really concerned we're making the wrong
choice is to make a smaller slice for the (single) vendor space, like
size 0x1000000. Giving away smaller keyspace acreage now for vendor
extensions gives us the flexibility to either expand it later if it's
working-but-too-small (since everything up there is currently
reserved), or abandon that chunk of keys and do the other thing with
the remaining reserved area.

-Evan

>
> Thanks,
> Philipp.
>
>>
>>
>> -Evan
