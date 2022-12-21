Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE265338E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiLUPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiLUPip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:38:45 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9817222BC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:38:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1671637083; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=YtcM+Iz3r8jkjev8FMSfjCgSrEZFmHFI2VlA30lBcgv9YBhuaGuY4zHvuswJA072Iyd+U2B5f28favQuPwsLMZEzHv5IQ0rNwpmhE7WjfrE4neTBOKO941ABOCq4hM106KlrhFJoR3AmHEqyn1/VgaDFp0PAB88s2wxlinqduaw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1671637083; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NSC4qFEML6JXScA68OwOMvTL2VeNJw9INIEB/X5j5DE=; 
        b=Rr0YzyGueqTu31cRn0TdhGj6+wrgC/YJ06BE2HFYvhwy+wRWhX8ZEI80Je75e06ncW4OPjuREpuPjCiterht6LHx9SIjAdyFl92ZRVilIoRQknPMzAcRDU6nw9XnPWIiIUvCP3MJO0gl2ZdFiKrTdoEPzPha0H1kISVM+ZkB+ZU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1671637083;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=NSC4qFEML6JXScA68OwOMvTL2VeNJw9INIEB/X5j5DE=;
        b=lLYfPW003I/0101fGgO0uqwxVrjtA6k8WT/5ycLvSBx8ecVFBlVmyJ75qo+DRSk+
        /ySfzYBNG0gW30Fr+inPccfcrnB5JoHVa3LR/ZsjYaRfmTiwx6bEJ+PFRpwymmRhw++
        0SDWoXVbdqt8nGRcxU23V0MX0sNRYTmoXccCGtck=
Received: from [192.168.1.9] (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1671637082214850.5013694823708; Wed, 21 Dec 2022 21:08:02 +0530 (IST)
Date:   Wed, 21 Dec 2022 21:08:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 04/10] drm/print: Fix support for NULL as first argument
 of drm_dbg_*
Content-Language: en-US, en-GB, hi-IN
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <cover.1671566741.git.code@siddh.me>
 <3ebf0d61ad5e82875a4493108602e62429306b14.1671566741.git.code@siddh.me>
 <e10cf9f1-af23-4355-7768-7d5010a28be0@suse.de>
From:   Siddh Raman Pant <code@siddh.me>
Message-ID: <16b08ba3-0d38-eb0f-8d4d-1da55ef38852@siddh.me>
In-Reply-To: <e10cf9f1-af23-4355-7768-7d5010a28be0@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21 2022 at 14:38:08 +0530, Thomas Zimmermann wrote:
> Hi
>=20
> Am 20.12.22 um 21:16 schrieb Siddh Raman Pant:
>> Comments say macros DRM_DEBUG_* are deprecated in favor of
>> drm_dbg_*(NULL, ...), but they have broken support for it,
>> as the macro will result in `(NULL) ? (NULL)->dev : NULL`.
>>
>> Thus, fix them by casting input drm to a temporary struct ptr,
>> with the same convention as in __DRM_DEFINE_DBG_RATELIMITED.
>>
>> Signed-off-by: Siddh Raman Pant <code@siddh.me>
>> ---
>> =C2=A0 include/drm/drm_print.h | 89 ++++++++++++++++++++++++++++++++----=
-----
>> =C2=A0 1 file changed, 69 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
>> index a44fb7ef257f..53702d830291 100644
>> --- a/include/drm/drm_print.h
>> +++ b/include/drm/drm_print.h
>> @@ -486,26 +486,75 @@ void __drm_dev_dbg(struct _ddebug *desc, const str=
uct device *dev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __drm_printk((drm), err, _ratelimited, "*=
ERROR* " fmt, ##__VA_ARGS__)
>> =C2=A0 =C2=A0 -#define drm_dbg_core(drm, fmt, ...)=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
>> -=C2=A0=C2=A0=C2=A0 drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_CORE, =
fmt, ##__VA_ARGS__)
> ...
>> +#define drm_dbg_core(drm, fmt, ...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +({=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 const struct drm_device *drm_ =3D (drm);=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 drm_dev_dbg(drm_ ? drm_->dev : NULL, DRM_UT_CORE,=C2=
=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fmt,=
 ##__VA_ARGS__);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
>> +})
>=20
> Instead of doing this for each drm_dbg_ macro, rather add an internal hel=
per that returns the device or NULL like this:
>=20
> static inline struct device *__drm_print_dev(struct drm_device *drm)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0if (drm)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return drm->dev;
> =C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> }
>=20
> and change the macros to
>=20
> drm_dbg_core(drm, fmt, ...)
> =C2=A0=C2=A0=C2=A0=C2=A0drm_dev_dbg(__drm_print_dev(drm), DRM_UT_CORE, )
>=20
> and so on.
>=20
> Best regards
> Thomas

Sure, I'll send a v2.

Thanks,
Siddh

