Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37DE746131
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjGCRLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGCRLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:11:41 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90402E3;
        Mon,  3 Jul 2023 10:11:40 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1b03fb998c8so4602219fac.3;
        Mon, 03 Jul 2023 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688404300; x=1690996300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr9Z+jCllCPo2TEYaCvE923MwG2oQxSBRUlumqGiOe0=;
        b=mc3vghlEgnyFSk7D/jcCzO1QYJfy+2euI1l4LO1kbhRa4eL0G6ATMGOIHPLt8GD0jx
         zRQKc5SeLq+nxXCqR1dT16rQ2tv5IBKfzaf19Oun31eJ0gpYwWFq4U3+EEUkopkrmMXQ
         lgfetNCzYXf54MlXaz9PQBGph+wF6oPowkOccv70aUjWyk+PBj9pwgz38X/IlIu24qkW
         j1MWVKyn0h0w5sAOxevm5sRjcKHd1OGHQ6nendorq5p7peQY0w+YMjof4BhFvo0Y2xrM
         eCf+Ak49M7VAWhauwX9EVTNeUgSXUqcY6m9DCpMZUfemv+qtTnTG0XHv0UPn+QJnjxwg
         hr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688404300; x=1690996300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr9Z+jCllCPo2TEYaCvE923MwG2oQxSBRUlumqGiOe0=;
        b=HUs5s5kITgL0fCujWISjtVhrfX/vMUdkup8cv4MFBRVNlEcFSSfQ+k3fAoFMyhB1W3
         Kr6f1G2e990n9W2vqX5WRRiHrkX9N6CV/GskQ31WrY63xYuBc0ypepD7cy5bPa7mKWpe
         vG63k+hMQldwn7/ZnzjLFVcBNlkV0TPzQLCd3ds0YOqLD1FEHDoWdGjpbbuFNOOfA2Lp
         VH145t+mzbD32qIe08J0O/1k7gcE86/MS5v4Xnnj4/bZEtH9EIMfkueH6zQLUhJ17+lL
         Bxr3ZDpRiwe1Voyx52DeT3ln0QOoX/0eKsLTKXR9XkrgCLxiKiw6MO2atOnR8tGvnFjT
         S8yQ==
X-Gm-Message-State: ABy/qLasz0zGzvG2OJqOcPjLeAqBmw8+hNVLxKPraGiz7oMu5SI03uMZ
        Zs/E2mL2O9E7C+nq9KNx35/ohL2A3r1NKW+DcFWN1TNGZfM=
X-Google-Smtp-Source: APBJJlGEUk7iZHT3ezXIJ+HAfuI51ogHZ6tS108CpDDo0YFCiXk0x8jA4twCBfPnwekP5IQeIzEClEKqljHuEuypaUk=
X-Received: by 2002:a05:6870:1495:b0:1b3:84a4:630d with SMTP id
 k21-20020a056870149500b001b384a4630dmr6215525oab.40.1688404299874; Mon, 03
 Jul 2023 10:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMo8Bf+rgAnzMF732rzNgWbnmijFbr1yd5aCiY1Hcf4qdpj6FQ@mail.gmail.com>
 <8ea68c1e-fffc-6443-d2a7-d540f9b5bb16@web.de>
In-Reply-To: <8ea68c1e-fffc-6443-d2a7-d540f9b5bb16@web.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 3 Jul 2023 10:11:28 -0700
Message-ID: <CAMo8Bf+ABwfqfi2hnyCdwooiogN7JMvq_tS0ZDYkytkYZ5gE9w@mail.gmail.com>
Subject: Re: [PATCH] xtensa: ISS: fix etherdev leak in error return path
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Minjie Du <duminjie@vivo.com>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com,
        11162212@vivo.com, Chris Zankel <chris@zankel.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 9:02=E2=80=AFAM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> > > We fixed a bug where the variable dev
> > > was not freed before return.
> =E2=80=A6
> > >  arch/xtensa/platforms/iss/network.c | 1 +
> =E2=80=A6
> > Applied to my xtensa tree with the following commit message:
> >
> >    xtensa: ISS: fix etherdev leak in error return path
> >
> >    iss_net_configure frees etherdev in all error return paths except on=
e
> >    where register_netdevice fails. Add missing free_netdev to that path=
.
>
> * Did you add the tag =E2=80=9CFixes=E2=80=9D because of the completed re=
source cleanup
>   for the implementation of the function =E2=80=9Ciss_net_configure=E2=80=
=9D?
>
> * How do you think about to replace any statements by the source code
>   =E2=80=9Cgoto err_free_netdev;=E2=80=9D here?

I've scrapped that patch and committed the other one instead. See

https://lore.kernel.org/lkml/CAMo8BfKe1nR+UP1WiUWFX0E7GSEfHsF8bZapsUYu3NFTn=
A8_AQ@mail.gmail.com/
https://lore.kernel.org/lkml/20230703170335.1340104-1-jcmvbkbc@gmail.com/

--=20
Thanks.
-- Max
