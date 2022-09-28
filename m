Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7985EE0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiI1Pmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiI1Pm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:42:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D9B96FF2;
        Wed, 28 Sep 2022 08:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIOuIAKazhbAa3CKxLfa+S5EQ7QBXnQSNh83GiK5HhJ88lk656tl8BOjCAMAP8Yb7ip0rp0JIyVtyJbRktvY+fPo4UN/c6JbQ4E/r4UiSvM5o1k61H0j4zUOMAPB1HZwIl9cycHMhO2i9PYCucH82XxOQ3XIe1g+b6uRzeBsYKKgLqpz+q68pJ3rhT5WlDT84XITw+Nm0q48Y1VDBfrewT69Ki4dzL2i+G5Wnz0+9IaIoQ+NADqDY9lHKfT6a8a/zCLDPFdjYVIM+du/dezZD5hKRkQINSjCLFxt/bueBED/fOSQrrUOULosacsNbQ9dZMls9efHyUh6w32EjX7s0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lzC1BAVpGna/lMSvv6c6mq5U6KVILNHw1ybKvlcuBI=;
 b=XzATf71tO73kZQIqigkJpV1soclckI2kzivnw3F+Tq7syJBHVVDciD2NMHnVmhbtu8obUWqeXNLwlALdzLLv4Qr7DTxfx1mK0HkoLtCCLi8l5mm7MVovvHPDoZEZLYwAAdMdLwmRfM5EyydZwdMplCsSS5GtoEwkXKlrdwJtbHwvBfwagc+GyN5qU7bN/OOkhzr5pPBfzeLZykhLwZzxZI0efBPpag1jm0EU3QjXc/PfhbBWNgsEOukZ0MPbjhNUiC+zNGUeGzM5Xx3izKknnl3QvnAn3RSEbNcTFZ5RHWyXsR5jqdu34W8SSv6pugd3dR+aHvXnIKgEuBmjg6EQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lzC1BAVpGna/lMSvv6c6mq5U6KVILNHw1ybKvlcuBI=;
 b=G5qmkAu4y+WSUQ2Xzj5U9rlsYWi1Y/jfn0+VyjGu7ZbzV21ggY9W/U8g4JNa3UYIKmEbAEstIUGozuJb8Dpoj5aSlWQaZibgndoUGYAy3OBvYkVDfqDDInrc9nuDCKlphugch46kc2YqpPo+u15fOLrJd4fy7zixmXab22njc5uqQUpcvmoeS75Y0Xs+FEBQYM/K/0drPpq8bLjUKxhgysMGCoLguYUmL10AqWj0m+5Ks6B0+M4JcWK+8MloSHsFAxw4EkREGu8Lb3kbI9oNHWfSq5bpjGj+vPs3/YJhz+Xn+ZyIKe7OuS8rHlAMblHaHQekec8KOFuKRkP5ODeLcA==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 15:42:23 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::7940:4aca:1c44:40eb]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::7940:4aca:1c44:40eb%8]) with mapi id 15.20.5676.018; Wed, 28 Sep 2022
 15:42:23 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Sanket.Goswami@amd.com" <Sanket.Goswami@amd.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: typec: ucsi_ccg: Add OF support
Thread-Topic: [PATCH 1/1] usb: typec: ucsi_ccg: Add OF support
Thread-Index: AQHY0zlBltfV3k63q0OMSa5HBSKL7w==
Date:   Wed, 28 Sep 2022 15:42:22 +0000
Message-ID: <PH0PR12MB55003409BBF564B990E1CD83AF549@PH0PR12MB5500.namprd12.prod.outlook.com>
References: <20220928125227.3045703-1-waynec@nvidia.com>
 <YzRbN5tS+epkOVfV@kuha.fi.intel.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5500:EE_|IA1PR12MB7686:EE_
x-ms-office365-filtering-correlation-id: 504db8a6-07ae-4fee-1721-08daa1680940
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqQCDvJZQoJBBSEKwq02Pz+eQI6aNmhX3nMr+yX0qiZxHQ7DyS2BsWg/a0ef7tATlYPLcsbJhxCsi6+EGOQtVicY1178NnLrSffCESbNux1Ftg9/TivtJ1YjvmbYMPj01Ayx2PhbXWnFEAmm/gCTe1lqpTiKsHT7BA8YRDTjcD6pHTn8HmwN37G5wiJA4JWbZsSXt1JA0YE4ftC2jmbWPawst/G0gVPUy6x1MDa6R5sqamxyX2P6MSB8Sf8LzspesJ/oBE7bT+95LVfUB0TX7GCIWMNIiNESaPcqvPotAwJbFiVf++Ssw5yaJzCCWeJ/CMowIB0gSkrm2Tjd18GvX3pAHcUpEVCvWixc2a8NcFzDzdv79Hn+OCpNfrYbJlIov2lusyieEyEMZLspsqewg7BMyYCEHgNvWJaIwGzybIeTHdJo7lBSUIRUB0juDRmnpmr66r04O50qSd+POW1nHcpIaAO5BvCMKQ9KFatXenFExHxkqzB7vn4zcdwMlyOP17Is6FF9g6Fx5oSppBnSp52XiZFJdkznd6prrNLUQNtXoP9kpICpGYZ3OqewVxHYRPqP/Sq3rWgOD/1WIl/3pPT7ScLXya33TfpEOdLQLBcjnG/JG8sVafgngGvV9322WL6GXuVFmT+QohLyADSS9z/16O1ktICp9kvYP1leAAm0q3yUvpTNdpgYgpAV6D2MlrC6IRQCi+5qpV72XZnwUXCd8ohRVy6Ux3ZUpC6ppXwzyIj6C+WxR3x8wC9e9BicWnmhyZwQ4JZS9T/t//2hvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(38100700002)(38070700005)(55016003)(4326008)(6916009)(54906003)(66556008)(66446008)(64756008)(66476007)(316002)(66946007)(91956017)(9686003)(76116006)(26005)(33656002)(8676002)(122000001)(53546011)(7696005)(186003)(6506007)(478600001)(86362001)(83380400001)(71200400001)(8936002)(5660300002)(41300700001)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K0Fbc32tX+rQmf7k3itIZhRBC6uxyRsipxdsLaL0AmVpbVLhw7i+FxG8NbSZ?=
 =?us-ascii?Q?XqH86zl2tt+QkuwQeOfWWluByKW5EKPnTAsSrajaQmW9U7J2lNw5Gm4huOaI?=
 =?us-ascii?Q?FbKHHwiWR13baShGajzwd3Qw7XepXiMUS1agSiGB3E4vTH+5SCOg9N3pSKex?=
 =?us-ascii?Q?p0vh0o/mIVL2xUt4wAcd6fFsVaWzvTJTFVfP8X9D/8QA0KbCJ6AcDEmvWs14?=
 =?us-ascii?Q?d+OXwbPDm/ucxZSd1wg1OoXEHucUCWyXlHaBEMwVkBY4AsQvCJgDrfVspYX0?=
 =?us-ascii?Q?EPNg5LsU/RLILjuJrmspt9zJfpnDbWMm7ixI/0PqCkwsEXznpg2dRk+yFOwh?=
 =?us-ascii?Q?qnt3E5KqM7SPz7nE9jDG3SfF3Da2nb6XRPnnSMbnluiNgHXPXtA7p1cZ5lOY?=
 =?us-ascii?Q?ZLrZzIRIPn/tPD5DBS8q8Wr0/baipSMP6fKHcPfWdz+ZwqppYMtfJRAU3MyC?=
 =?us-ascii?Q?VkdLpxJNDr9swsbmPaqKCuR+v3PK3TDaVyzYYgSFtbUKizaRNCGtHIHOsAvX?=
 =?us-ascii?Q?HCHBoV//5c8Aqk+M6Csn3GmAVOP1QNnIskGrumHkxRqAjXssPCdbeYswBLJG?=
 =?us-ascii?Q?no8du0IohiT8Pgr2dvcVmip6KfKPgKdGYeFHlNxU7wDI4JGxikVbrUfe9nBt?=
 =?us-ascii?Q?fi3/sA4XVI+WGpVAuY9iocUsanCSkp2B5mRXNuLeS9J+eYP79ztp+PV9B5of?=
 =?us-ascii?Q?kdC7KLuFMgN2rl57Vt4Tz4HbxYlaTo8U7IgOkwFV7f//jI7MoeTtqpcsYBUx?=
 =?us-ascii?Q?ftjWOh66Hj7tYi35v0hIUt0SFeDPOP51QzRYhL/t0xPXeXgQBUZ43XlDmNVP?=
 =?us-ascii?Q?Xi+NOTZd/65Hgufd7u1pNkpiNBl8PwpgAP42GfWoRVMMsvzB4VpA+ZY/5zw3?=
 =?us-ascii?Q?7FoS/eR3W2QJjc8H8Jwg+/urPkpxHsleFjozw97QLGoiJuFkUuZlqV/Savul?=
 =?us-ascii?Q?sPyvaOW6EL7AZ7w76Ljg5rY0dQw9DTu1DUWQZ9aRkyMKVNGmdSee53KN+Dop?=
 =?us-ascii?Q?Q9D17mFd7c2FJuK9BI8rqe19bla5fs7fOz6DBzle+omxj41O3wI1+yJ1BsWg?=
 =?us-ascii?Q?ZfN6aRvevdUhfEe8jrvPrXfgzZzvjjjGcbvxjdeIHGU7cr0LrbZN+vrCtzfp?=
 =?us-ascii?Q?raPaVcKizdhl+DTCq4HkdpncyFj5+wrSgckjJgbRXHVRWKfxjK9nJFP3bwwW?=
 =?us-ascii?Q?D2nd72LZ5vyHQpXKolTdTAxB7LB0CUaPLUCAtiFlE+QWwhYz1OTN/SzYZ80p?=
 =?us-ascii?Q?BzASe5FcbfPUotp4DsdAkNIrn8lHRHNq4BilshlrrM20847xr0taOBSL6P/R?=
 =?us-ascii?Q?QUXl7xs6jeXvKc6hmsXTyB9aek3c7qBNTAczCax1Fv0izbG45x5xjHaAFvii?=
 =?us-ascii?Q?RrHxK3DTdLnbqNGV9wXs2ayRI/9jUVKHO0nfqLZuKef9EdRo+4cMxF63TO9y?=
 =?us-ascii?Q?oVCG1Fzww9Zmff/gjO+7QdtmasyG3fUup08UwTCjNszoGoH4NJBtmYElJqP1?=
 =?us-ascii?Q?JSjnVCauNadpGUjBZSr5FT6N7BL/zgxXytyRr0qZt2F7KROks3HwVcWv0yYg?=
 =?us-ascii?Q?fg1YG6gaqul2Ci7Klz+lfYjvvVVPRSB6HUmhyLLY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504db8a6-07ae-4fee-1721-08daa1680940
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 15:42:22.9899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozT//MtPekMppqpjwwZL/jwGNtX3RVRadUcdpE5Hel359Z9hEYATujAdkVwpj6o4AmT+Y9GLxFwQW8yer+s6YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki=0A=
=0A=
Thanks for the review.=0A=
=0A=
On 9/28/22 22:33, Heikki Krogerus wrote:=0A=
> External email: Use caution opening links or attachments=0A=
> =0A=
> =0A=
> Hi,=0A=
> =0A=
> On Wed, Sep 28, 2022 at 08:52:27PM +0800, Wayne Chang wrote:=0A=
>> The change enables the device tree infrastructure support on Cypress=0A=
>> cypd4226.=0A=
>>=0A=
>> Signed-off-by: Wayne Chang <waynec@nvidia.com>=0A=
>> ---=0A=
>>   drivers/usb/typec/ucsi/ucsi_ccg.c | 9 ++++++++-=0A=
>>   1 file changed, 8 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/=
ucsi_ccg.c=0A=
>> index 5c0bf48be766..36442508bc37 100644=0A=
>> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c=0A=
>> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c=0A=
>> @@ -631,7 +631,7 @@ static int ccg_request_irq(struct ucsi_ccg *uc)=0A=
>>   {=0A=
>>        unsigned long flags =3D IRQF_ONESHOT;=0A=
>>=0A=
>> -     if (!has_acpi_companion(uc->dev))=0A=
>> +     if (!has_acpi_companion(uc->dev) && !uc->dev->of_node)=0A=
> =0A=
> You can use:=0A=
> =0A=
>          if (!dev_fwnode(uc->dev))=0A=
> =0A=
> instead.=0A=
Thanks for the advice.=0A=
Checked the source code and verified.=0A=
I'll update it in the next patchset.=0A=
=0A=
> =0A=
>>                flags |=3D IRQF_TRIGGER_HIGH;=0A=
>>=0A=
>>        return request_threaded_irq(uc->irq, NULL, ccg_irq_handler, flags=
, dev_name(uc->dev), uc);=0A=
>> @@ -1417,6 +1417,12 @@ static int ucsi_ccg_remove(struct i2c_client *cli=
ent)=0A=
>>        return 0;=0A=
>>   }=0A=
>>=0A=
>> +static const struct of_device_id ucsi_ccg_of_match_table[] =3D {=0A=
>> +             { .compatible =3D "cypress,cypd4226", },=0A=
>> +             { /* sentinel */ }=0A=
>> +};=0A=
>> +MODULE_DEVICE_TABLE(of, ucsi_ccg_of_match_table);=0A=
>> +=0A=
>>   static const struct i2c_device_id ucsi_ccg_device_id[] =3D {=0A=
>>        {"ccgx-ucsi", 0},=0A=
>>        {}=0A=
>> @@ -1471,6 +1477,7 @@ static struct i2c_driver ucsi_ccg_driver =3D {=0A=
>>                .pm =3D &ucsi_ccg_pm,=0A=
>>                .dev_groups =3D ucsi_ccg_groups,=0A=
>>                .acpi_match_table =3D amd_i2c_ucsi_match,=0A=
>> +             .of_match_table =3D ucsi_ccg_of_match_table,=0A=
>>        },=0A=
>>        .probe =3D ucsi_ccg_probe,=0A=
>>        .remove =3D ucsi_ccg_remove,=0A=
> =0A=
> thanks,=0A=
> =0A=
> --=0A=
> heikki=0A=
> =0A=
=0A=
thanks,=0A=
Wayne.=0A=
