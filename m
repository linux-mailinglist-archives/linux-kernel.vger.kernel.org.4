Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F3E68CCAC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBGCmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBGCmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:42:19 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B75C2D49
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:42:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSR+XyU+EPjDpEuwQ6jzMN/bbSYHVMXdaPQBX1Kmz1qgfeAlJXvvI9LkBxCGgT9lpc7uMlSmGgPELUU0TSkwCZnMXbTIdpHWaWuYmnvb9LRhvIOvJg+DcJHZTeiNkJzTZ1wNeu4jUbX2Pu2pTeFRejHQ3zLKrfXisQJEK95Qc/hPXBCUjwEnXi/TAAwFgUsv7WJoMk2lSqwGfNxwMfEp374U9fgM+ijulynsr/OwuSc1ePfcESDzqF7Eve33fn24wZEBh8iuCelCvV6V7Vv7usOO6+sCAasCFk8f2ZbcAWerAZad09k87sulA2ycCPZFzO2gz/BZRInqH26VjgP34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhVzsA0Jm/GRJZOc1XNw/4Jy9V7dJkpFSlNJKgsYr2o=;
 b=Rv+Hs8VIIM6HbCwYFRLyNDHVt/NN0Tk6OduwJK6htMLhVPqU0UoAEX/3keg2njPKtlCyYD8ipr6I1Ogi9VYBAY7vrLLnylSX2sODXkVl75owNeN9ycL2EW112iTC3Ra6HYZC4w2yGWZsT3MloN0vS+5S8eUeDxqKtW61IaxFj5pgyhLC5CY6umtq10dD0jAvld1TEqZcXCNb7W01zcME0uvwes2J9ARixZEpx+80KrY7QXjBwVaAzhryk4DaU7gDBw0tsPGpoZ8Qvr+XSHisdCQ6RewzHt4KJQMFkToBEvDn2+5Ptub/l1Z+W9Er19nQw6N4HnU0jXaVkGU65pXLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhVzsA0Jm/GRJZOc1XNw/4Jy9V7dJkpFSlNJKgsYr2o=;
 b=FRd4bM3gY1oN79cDgXsFF+cJDFky1tjEAQy0BkudOvPwAOOH+RzRvckbnMCYdxE6A4lEi0aKK8cAtj0b0E7EvKmLm6Ec6Jq4QCBej87+Phd/8vSqvErsllSN5I+PFhP+jKJIKswscSKnMjvNww+0jjTnMJU4mjGXcDqxXdXBbF4=
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TY3PR01MB12050.jpnprd01.prod.outlook.com (2603:1096:400:408::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Tue, 7 Feb
 2023 02:42:14 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::9438:5139:7952:d8b0]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::9438:5139:7952:d8b0%9]) with mapi id 15.20.6064.035; Tue, 7 Feb 2023
 02:42:14 +0000
From:   David Rau <david.rau.zg@renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Thread-Topic: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Thread-Index: AQHY/Wc8EHyTvYawJkGeL+1XJ6BDpa6jYNiAgAIOc/CAANeEgIASDP8AgAAoZACAAGKRgIADYrqAgAAUigCAABqigIAAD+IAgALjMQCAAlK64IAAtqWAgADI8OA=
Date:   Tue, 7 Feb 2023 02:42:14 +0000
Message-ID: <OS3PR01MB6641BD5C3B3BA89F82245627CDDB9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
References: <20230117195645.GA83401@roeck-us.net>
 <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230119161221.GA981953@roeck-us.net>
 <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
 <Y9kE1cSUg2CQM5vq@sirena.org.uk> <20230202155101.GB1373010@roeck-us.net>
 <Y9vtIISfmpICi+9u@sirena.org.uk>
 <8f89eeac-b3ef-4137-80df-6cf044873b05@roeck-us.net>
 <Y9wQygzbFyOWl54r@sirena.org.uk> <20230204154222.GA877819@roeck-us.net>
 <OS3PR01MB6641CA1DB8524BCA0F9867D9CDDA9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <1ba5cedb-0f0f-69a9-96f0-d93ba060745e@roeck-us.net>
In-Reply-To: <1ba5cedb-0f0f-69a9-96f0-d93ba060745e@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6641:EE_|TY3PR01MB12050:EE_
x-ms-office365-filtering-correlation-id: fac593d8-0f78-4737-3b3c-08db08b4ebc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rkbVLbvdoUF1k1NAmzGAKJitWnscPW+6uImtOrMyzmdw/U0SKpMuutsRmervDMHZ/H9cLju8XPX+nVFfBDdPAJOq3TFRvsnQSKJu+BKMO7eddpbwC7k5G5LfToUHaY5PQWjr3Agz6k7lx+5HC1uLURjuQT9SqVbN5JRFDQ9EJtJWr6XDd2Lox9R6kg/2nYuFgBvcAfYLYgNBclRvQaU/j2A7sUdDThT2no1iy0gsUjI+M9JShWvmw10iptiYSVhzm2Y4Et7IEZhKZn5/uxGXAbs7iReOi+WJHCFBZln+2NcUT5V+G7SYAhUhIiRSUddBavKC5UAEAdnMunKAXuX/rZrlxgetMbG83aO3kulw4uH/3p0Nn3TD8cSe88ldEmU5lfq3VKsepx/n08IuTM9xpV7o+T8EugCftr4wKpl/Q+lrojfd/KqqqPMAFcgOPlQ0+N1yo6s8Wfi8M7ECVAb8K+y1KEWBj+be9VRbmzZhQi1XHDCDwmc7UTFA82mAKdTs2I0FViNrsae5pfXS4W+QGNiWR2ZNsrUBW/xfTd79KjRPoTvi7A53BgmVtlJjv/mte71SRDud5xYeswV+GXbxF0l13wrOzzh7pQJ01RaTub/XuIY9A0zHy1W0cjAQhT357+exqfrkajW8vni0U+gpyRavQRpJspwag/VU1C06nLlROLWXQVDxud9qEGAhtlOM9HGOIZ2OZ6ghIN2s1o2IXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199018)(38100700002)(33656002)(2906002)(122000001)(86362001)(966005)(7696005)(71200400001)(55236004)(9686003)(53546011)(45080400002)(26005)(186003)(38070700005)(55016003)(76116006)(110136005)(54906003)(316002)(83380400001)(8676002)(66556008)(41300700001)(4326008)(478600001)(6506007)(66446008)(66946007)(64756008)(66476007)(52536014)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pdYiWU2U/yg20kW/TnlERDO3k8qzRL0WaR7bmY3e/fv7r+1Z/wRKJunSmuhZ?=
 =?us-ascii?Q?qYOq/AFfZRuvWruHG3JJqDVOm6uGhm+KTCOikSTAV5VUwy3HPKZmXNXknrWj?=
 =?us-ascii?Q?xcHI2ZI3plduBgT9ImChBaZxjKj2fJlKvyplCvB0J/B07SZ0JILnWb/tXgNw?=
 =?us-ascii?Q?WjKryBOPkyagmTXH6JeC+65GkEXKHTfdtT2DwC4r6yZlAPBHJUx9GoLLwjnx?=
 =?us-ascii?Q?m4uPby/decuLonoj72AmW9qFXYi8Kb/ToryYT5yzniMAkUdg2KFC9ARiXip9?=
 =?us-ascii?Q?y19qR8bn47t+AxfLGgZqiI4Y5NK4ysYu78GJ2DfRR/6qZxdPM/fR7avKHwBL?=
 =?us-ascii?Q?aZkqcMm/jpzu263GFXIYDPraFpg9KbULIDGAmCkFQCP7yqQzUwONcpbjv2KT?=
 =?us-ascii?Q?MqlELxJP3Jg3zUgHqMQmba5Jfqg+ZplUbIIW90opfNI7VMTWX6ceWjI1AR42?=
 =?us-ascii?Q?g64Id8aCJUu4nQ6+Idtr8y4dfA9M5eXmMvrmODWSDqjGIXvNApJoY7/Ke1O5?=
 =?us-ascii?Q?TE37n0wEeOJe+lJu9J4YEh9+KOFG+dVMq6aBB82wg9l7gFsNboX1q3OCYHQW?=
 =?us-ascii?Q?ExLVE6wvhgPX3kHEsL+3sYSoGIC2DU5wWx4gzW9vDNCQ3yE92fyTujXew3Hl?=
 =?us-ascii?Q?XjiR5/OqarokKNKnDWknls7Nnup6ozE88qDiUgnLcH8j1XWeFhJeO7OiSZ6m?=
 =?us-ascii?Q?mox0UzdeYD1ysxc8FJ6byzCdReFrTrfsuJy9PNmSi69K2q1FAu6PY7M1Cwi2?=
 =?us-ascii?Q?Rg4hMUb4kaK1/6NlisX+75NYxHHF5ebWlXrhnAE+CGfYWXyZRn3SkhXWYZVD?=
 =?us-ascii?Q?UCbM5SBkmBadWx4ZuGDkXyuyvHZaFgtIBjHo6/xr+0NH/cVnAr1SC4i3QR9b?=
 =?us-ascii?Q?k02OgISij6jODwYoi/MTj/Bu0Sy0eh7vB2FelmKhKgkr1FzorQ5JV6VfPW5c?=
 =?us-ascii?Q?IM7HWNLvwTWSvzgN0nA6rUS+crDZKHDEkUnRMlhQi1YJfdGGBuYNufoUxJqC?=
 =?us-ascii?Q?gcSyArTdZ5cRLKQJfM4Or+G2sfK/FLCg5ZQUA204QSGlzqkY5Y7JPHLvGRIh?=
 =?us-ascii?Q?ihKFUyXRHUNe5tHgXz/pO/5Lk/SEWKnf5u1R1KzB93E1sgb+5pYtca3zCrVO?=
 =?us-ascii?Q?C8YQh+qx6Wcs+hajCcMOjWPkJGHk3DuK+EKofLNca+Pbyj7uZHFFb3+bxZc9?=
 =?us-ascii?Q?mtF5zL4yHDfiSmJ1d0nCMbQTJ5pgN6xEodzZuTe1JPfXjurWdTi36fIkYdMR?=
 =?us-ascii?Q?hINgEpafoEI5UgpPOsrN6Dili6d6phf0JAQFa/ra/HkIMwmv5K7POzYJumsy?=
 =?us-ascii?Q?PYZmkL+P5OKOT9FsItIflUYD+g3NyyL2C2AwFi2fQB2uaMASVIMFySMp6VPU?=
 =?us-ascii?Q?d//AItYirfuPw5QOvMcILNd0n3UCbhQTqwOV9xJmOT6+/hZ5K4x62SoNvseo?=
 =?us-ascii?Q?ckk6IbUPn5kk7t4LWbUhuoRjlZfEUD5dqZA6wMk1fDG0LBCCwdyYom+UtoVZ?=
 =?us-ascii?Q?vaCunYD+Ze2kVETbOHeahzhBsfGpyiPRo3W1rxMaTA+blrzGRhWt+loyoaPE?=
 =?us-ascii?Q?ISplzwxToTHfN84hl5J+9M8vOf6IHFAj/oI52Tpj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac593d8-0f78-4737-3b3c-08db08b4ebc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 02:42:14.5517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vj1ofstoK9aac+YcmJUsSDDojXrj2rEu+LSSUrgercVT5HHTHc1d/lXXz0XrYqJzURPrp65gQMz7CaFIP6GW5lJCPOoMfj0nFTQ9z2A42XU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12050
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Monday, February 6, 2023 22:05
To: David Rau <david.rau.zg@renesas.com>; Mark Brown <broonie@kernel.org>
Cc: perex@perex.cz; lgirdwood@gmail.com; tiwai@suse.com; support.opensource=
@diasemi.com; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP h=
eadsets when playing music

On 2/5/23 21:38, David Rau wrote:
>>=20
>>=20
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Saturday, February 4, 2023 23:42
>> To: Mark Brown <broonie@kernel.org>
>> Cc: David Rau <david.rau.zg@renesas.com>; perex@perex.cz;=20
>> lgirdwood@gmail.com; tiwai@suse.com; support.opensource@diasemi.com;=20
>> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on=20
>> OMTP headsets when playing music
>>=20
>> On Thu, Feb 02, 2023 at 07:36:42PM +0000, Mark Brown wrote:
>>>
>>>>> they have the potential to actually lock up are the
>>>>> cancel_work_sync() calls but they were unchanged and the backtrace=20
>>>>> you showed was showing the thread in the msleep().  My guess would=20
>>>>> be that you've got systems where there are very frequent jack=20
>>>>> detection events (potentiallly with broken accessories, or possibly=20
>>>>> due to the ground switch putting things into the wrong
>>>>> priority) and that the interrupt is firing again as soon as the=20
>>>>> thread unmasks the primary interrupt which means it never actually st=
ops running.
>>>
>>>> That is what I strongly suspect is happening. I don't know why=20
>>>> exactly the interrupt is firing continuously, but the hang is always i=
n msleep().
>>>> One possibility might be that the event is actually a disconnect=20
>>>> event, and that enabling and immediately disabling the ground switch=20
>>>> causes another interrupt, which is then handled immediately, causing t=
he hang.
>>>
>>> Could be.  I'd be willing to guess that it's not just one event but=20
>>> rather a stream of events of some kind.  Possibly if it's due to the=20
>>> ground switch it's spuriously detecting a constant stream of button=20
>>> presses for the affected systems, which don't produce any UI visible=20
>>> result which would cause users to pull the accessory for whatever=20
>>> reason?  Whatever's going on I bet it's broken accessories triggering i=
t.
>>>
> >=20
>> That seems to be unlikely. The average number of crashes per affected sy=
stem is 1.92, which points to something the users are doing and less to a b=
roken accessory.
> >> We do observe crashes due to broken accessories, but in those cases th=
e number of crashes per system tends to be much > higher.
> >=20
> >> Anyway, below is a patch with a possible fix. Of course, I still don't=
 know what the patch originally tried to fix, so it might not do much if an=
ything good.
> > I added the software debouncing before insertion task to ensue the bett=
er compatibility of OMTP Jack.
> >> For example, it keeps button detection in the interrupt handler to avo=
id dropping button events, so if spurious button detection as you suspected=
 is indeed (part of) the problem we might still see a large number of inter=
rupts.
> >=20
> >> Guenter
> > >=20
> > Thanks a lot for your big efforts to implement the temporary fix and ve=
rifications.
> > Would you please let me know the average number of crashes per affected=
 system if you rollback to the pervious fix?
> > Ref:
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
.
> > kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2
> > Fcommit%2Fsound%2Fsoc%2Fcodecs%3Fid%3D2d969e8f35b1849a43156029a7a6e294
> > 3b89d0c0&data=3D05%7C01%7Cdavid.rau.zg%40renesas.com%7Cae6910f8ff4e4e29=
9
> > bc408db084b1a2a%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638112890
> > 873388020%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> > LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D8KgHP%2FOD%2BTDc=
r
> > rUVSATFkDCDDmhiCu7d5%2FKhyOszThA%3D&reserved=3D0
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
.
> > kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2
> > Fcommit%2Fsound%2Fsoc%2Fcodecs%3Fid%3D06f5882122e3faa183d76c4ec2c92f4c
> > 38e2c7bb&data=3D05%7C01%7Cdavid.rau.zg%40renesas.com%7Cae6910f8ff4e4e29=
9
> > bc408db084b1a2a%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638112890
> > 873388020%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> > LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DWosfvANk0YxeJD5P=
G
> > %2FnAuAWVqt7m4U3mMaYXefLLdS4%3D&reserved=3D0
> >=20

> You mean just keep the above two patches and revert 969357ec94e6 ?
> Sure, I can do that, but feedback from the field would take some
> 2-3 months. Is that what you recommend to do for now ?

> Thanks,
> Guenter

Thanks for the feedback.
What I mean is just do rollback to remove the "sleep" patch I did in your r=
epository.

After the rollback, could you please let me know the average number of cras=
hes per affected system with the same test conditions?
Will it still take some 2-3 months?

Thanks.
David

