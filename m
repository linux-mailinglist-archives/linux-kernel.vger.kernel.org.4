Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0033C5EB4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiIZWyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIZWyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:54:49 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF96288A03;
        Mon, 26 Sep 2022 15:54:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4F2316D9;
        Mon, 26 Sep 2022 22:54:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4F2316D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664232886; bh=FwR2WYpE54nS6Bi8rW58E9/X3cSfe6Q+6dBH71Kd4Q4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R+yIk9EgkhvUSV2cwqn/6+ueJ4nLyDC/34FqBLXS429BG3babwjXeadLuDqiyDtqK
         Z4vlD05GHdaO1Mz806SZZ2x4bS8ofCJq060Lwi3IBW1Yax6cEPR8mShf6SXajPBTPc
         0nU8feV91O4hCfvgAsWKOlNmmLk0WsIG4lgfZ9anN2kn2dl3DM5Du2h8Dt05MwhgVU
         TCTLKdoA62/ZEd51iEhS/Sp590Spr9iEJTF3ip6+9rgzQrm0VXrxL8YhOYCnXXX8Q6
         gRLrt3MqHsDb3fxPtI/XR1OfXkx5OAP/+pIgZTiU4fVW0+2YNKN9Y68H+GwPPS5ar9
         O77LCGwCFWGRQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        broonie@kernel.org
Cc:     Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Manfred Spraul <manfred.spraul@de.bosch.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 jc_docs tree
In-Reply-To: <20220926224621.47llaskp6mihi4dd@tarta.nabijaczleweli.xyz>
References: <20220926210631.657728-1-broonie@kernel.org>
 <20220926224621.47llaskp6mihi4dd@tarta.nabijaczleweli.xyz>
Date:   Mon, 26 Sep 2022 16:54:45 -0600
Message-ID: <878rm5rbka.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz> writes:

> Hi!
>
> On Mon, Sep 26, 2022 at 10:06:31PM +0100, broonie@kernel.org wrote:
>> Today's linux-next merge of the driver-core tree got a conflict in:
>>=20
>>   Documentation/process/magic-number.rst
>>=20
>> between commit:
>>=20
>>   32ba63d4b2e1a ("Doc update: Correct magic values from nbd protocol, V2=
")
>>=20
>> from the jc_docs tree and commits:
>>=20
>>   82805818898dd ("Documentation: NBD_REPLY_MAGIC isn't a magic number")
>>   bd5926220ffe0 ("nbd: remove define-only NBD_MAGIC, previously magic nu=
mber")
>>=20
>> from the driver-core tree (and probably more for context).
>
> If I'm reading the merge right (very much not a given!),
> it seems that the NBD_REPLY_MAGIC (and LO_MAGIC?) constant(s) survived:
> they both need to go for reasons listed in
>   bd5926220ffe0: LO_MAGIC doesn't exist
>   82805818898dd: NBD_REPLY_MAGIC is part of the line protocol,
>                  not a magic number=20
>
> This also reveals that I missed NBD_REQUEST_MAGIC
> (needs to go, same reason as NBD_REPLY_MAGIC)
> in the first pass, but that's unrelated here.

I've been trying to make sense of that merge myself.  Is the right
solution that I should just drop 32ba63d4b2e1a ?  Manfred, thoughts on
that?

Thanks,

jon
