Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5341F5EDE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiI1OLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiI1OLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:11:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7DD9F1B3;
        Wed, 28 Sep 2022 07:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj3mkeWSdHKI3qBlRjNaOtaNbHeBJ48zSRQxmTHATaZp4VBoIWjsG0nvPj3TLL6jeLqq7ZlLR+dUM+5E6tWGgEZqHsqYvTCEuaa+lAJB9yifXxncZJwWQtvZOXqJ7iBbnBqrRngQIfxdxx/gMhd9/gWXNY3Ai6B6n5gm9N171wY20ySDx7kksww1cDSdJgyRiVgPFYaTFKMJ9zZe4BqgWMGG+2NJ6rhqGNwqOmiq/VECQnkEiltD+RTO9p5EcUOe7esczkt3uYyk0bC0lmr0vlC0ay5b+Fu4DQly5hwJhcCOjXzPqHows6/59iRCG8b1ld19m2patU+CRjR/93l4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9TFTMy19eZJCXnVULsQnNxGUDFXBvabIyKkbiwiXCY=;
 b=kefzzAAxXsre9C02sm9vbRGnYeGUfjY3qYVKoz3YAANYMs16YySplJ85lnjAvyxLcbBJbXa86ku/oyzFSgfGpf9kQ8HEve7zoGX5tFFz5EzsNPznJ2pGawjvrJN1DjtR053ePCEuYzlDzhJ68ACmJcFtduhDrZbbMjtob3hnDy5T7aLyMY7iwn1XcpxoCi6dIlQKL/FLIITDAhSOOr4AAbjz1MwHk72b7XzjNQnsLcPF5V51kx5dm3cvRW9uyILibo8su2KzAmwgK75sI7VBi0osTVLkVcJeHix4lqPq+FZj7PXvOIjNT8H+nzdRxr4kuUDu90o8GP3pVIwl99UEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9TFTMy19eZJCXnVULsQnNxGUDFXBvabIyKkbiwiXCY=;
 b=mmAJVAiG7TLJ4wueTcrLR0fkDhf6Ru//Qf8tmnRaEpNNMYx3iInXDEAU07S0AA+J30y9tpzmb5lL+5TLdS2NYufiNRJJ1qsk7CjPeMOKSvhWvU9l4na6YOejY1bxB0T2g1YH2p+lHzBGv8dbK9GozXzUmvaBE2n/nxemkEPjKYFPPNKbDllMof8otGqwE7qqwY4EWIDE/NC7DWu7IB0OZvXn+BXt8duChraYnpohjuOV92O68ZPF+OT5FfnVeBMm44QElKGniKh5vvqH3uJM+cXol0TocapwbCGt/kwyys+esTOMhLn76LhCwslOhWdQ8s7MSAFtz41jxo2Am5ipbQ==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 14:11:36 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::7940:4aca:1c44:40eb]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::7940:4aca:1c44:40eb%8]) with mapi id 15.20.5676.018; Wed, 28 Sep 2022
 14:11:36 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "Sanket.Goswami@amd.com" <Sanket.Goswami@amd.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: typec: ucsi_ccg: Disable UCSI ALT support on
 Tegra
Thread-Topic: [PATCH 1/1] usb: typec: ucsi_ccg: Disable UCSI ALT support on
 Tegra
Thread-Index: AQHY0zyLsV8S8CEBhECRiwMjQ26pFA==
Date:   Wed, 28 Sep 2022 14:11:36 +0000
Message-ID: <PH0PR12MB55004C29C12FA17B9767CE98AF549@PH0PR12MB5500.namprd12.prod.outlook.com>
References: <20220928131615.3286936-1-waynec@nvidia.com>
 <YzRQBEeLorfC8KAL@kroah.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5500:EE_|SJ1PR12MB6172:EE_
x-ms-office365-filtering-correlation-id: a9fd22c1-b1cb-4da4-c69e-08daa15b5aa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Aq8l77xo2g84xmyayssu/gu6hbPKF76tU3iaBXDz47pPLrehglhFPTGlWjiITIkQ9pb3qRU8pSHJk5aVAm6otb15dfyiAPRKOKo3PZldtKlSruK6mYE2cpruxb63MYwoYlIsj4jP/gz1t+/nkpJ4rGnr+xFirMMt2FZ9BhL4Tu6QpOwAyYIZID6QTp2ZtxbybgFip8Y7GY6abj3D2WGNUopgK7TITD3yU2c3v+C+yrUQwsBZzQ9+B0cQSr6Q6/lySReWWtIJUg/ooM3TOqXwOmTPVeSXRMn1tpsK2ezApJ7TwjmTSdL4I667EFtJ/oSkmsFzspeE15p3SRuIzF4xqSfmeGxYpF1fvB806I2c8dhmshx+ywtWsHf3lKdMcmG+790/qOnYEr5ru6nCC7UA34Hg9p+QaG35N4/FDTe/MbMUEwc3j9W7mC17ZsdJtfkZ+bG7LNcior/P8EqUcRcRRkjcPGXz8mu4hjNpfLsJbV0Qvi5osT6te6qRjPOLjPPbACG10TOBYiRuYBDNfLqwPcFGsMPPyM7R1Kzf+H7JtIgfHJv/GXJNpGu4b0ILxlPEdrqA2nE1NLO+96ApPaUvmOe9KLT7wHAgHVJL8Vwqhw9wkI7EKu5oH2eGKZGCYd3GU2D/AgDHj/PcMEbPGj4M1C6fSM3CdKlbTLlEzVeRiwoYzYFPzSMFmom38TVxHEo1/FpBvCoCsn+Q7QltEgoEYGe9b3W2mPFHuvuPmnUhEdcsIuQ46vUf84wFcUfiIFvgp51h/8P0D0leWk8yqE5ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199015)(478600001)(71200400001)(53546011)(9686003)(26005)(6506007)(83380400001)(186003)(2906002)(7696005)(52536014)(8936002)(55016003)(54906003)(6916009)(316002)(66476007)(4326008)(66556008)(5660300002)(41300700001)(91956017)(8676002)(66946007)(64756008)(66446008)(76116006)(86362001)(33656002)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rdj0Q3RWGJT67xERCf5MGEWCb/Jbubw8Q3+ORcN4mpymiO97T5ZmFrvrFDX8?=
 =?us-ascii?Q?hLY0zzxBgnq4n3F0aWEEPOjYiNfeQNXt/mz5wAxg0Kc0qAO/hQ5i29lrBNU5?=
 =?us-ascii?Q?HknaCGkNuc9Uhh8NGTjdLQ1CPD5xXxPJcxkcYM0kdbvFTx9qs42beOmMItVD?=
 =?us-ascii?Q?6/35zswzBMBxv2PRicDIsuHC9k+IhYkQDSBZR1A8ID6GhB08oznIkyUmczg4?=
 =?us-ascii?Q?De9NkRI33YbbvfiTiOc8j4LAnns+EAs2buzmENxry+xVhTERhPjI52YsiCrQ?=
 =?us-ascii?Q?SzRx6+watzWfubA5RML5xeqZeXqji2ytB1s7MY9lKiVECcNeyk1BBrebhbde?=
 =?us-ascii?Q?sWCI4A37Rs76+g6KNIyUbB468LP5BqXKzou8poFkntDlo0+w8A4GXlCvoWwA?=
 =?us-ascii?Q?RfP2/7EjOc1PNX5SUuzHaFFGptgriZQkGHH9zzbjsxtmFdghOKwv4GnmJZOh?=
 =?us-ascii?Q?7DqZjDUUv5dwI5LhAFUX7dGD3FAyFPeeU7hn78wNeTWOU1whyVg22QuG6H82?=
 =?us-ascii?Q?pslxP7knRTnDmFlBWG4dzUAdvKAyKO3hc+ZIUThAqZWR+EmF+Q1BPqO2x/wD?=
 =?us-ascii?Q?DSPXfKVEBaK6qjEXQiacQ00s33RfCzTKCi6l4fu3yWvrUX8tdkq6XRZu7ABE?=
 =?us-ascii?Q?NRQ9ohH3kQNKFhmuSfV9dVi1y7MsXIzHyQC5mzNfIJvlgq++gH74aGkcYvHy?=
 =?us-ascii?Q?XYIlQLqXh2nJM0Xy2BVAncWScYmwcrete1I/VuyZLCRS0/xeLl9op9OKzuEd?=
 =?us-ascii?Q?eQJOJyoFH/9Q02augnBZ2IHZc3z5CrB7bEYppeNezbVxCfQu+xSyUB2bKZft?=
 =?us-ascii?Q?sUutxeJgndZS5kVviw23qPoxYcu2shK8B6AMNCELItMoqyg7bdTQKSM4ihak?=
 =?us-ascii?Q?kxfGxabR67U5JdNZ6AkaE6upKvGH6whynzZruZPNnbQjMfYxD4oo4cA+8zCv?=
 =?us-ascii?Q?RHl7G7h7VkqQx1QN8VCjT7jwBqCy+02M2hi0vJxeTItuhOwogDTW5kG67Pe8?=
 =?us-ascii?Q?9wmJlSXGVfjRCa+9DP0pd3s4Z2EPMEUhpBD9gtVHzj/xc6AYzFvrQ+puw5lK?=
 =?us-ascii?Q?/2WeVtUal8FF6s3Rk7V0BaTsiNBQ46gfy500C8JJci56L1DtPjEJdDbwJfi4?=
 =?us-ascii?Q?FE9fN+B9RAapRwk68zh0lYoqy3wJX9Lxo1WTVvih58FkCmQmoVvoIAA6KwnQ?=
 =?us-ascii?Q?2shDv0z07z35yscJl0x7sXktCXWGjhyR1OtEuqjrPPZtUcnTM2Z7K8MCXhXd?=
 =?us-ascii?Q?Yj3t+r2Ue+pGMbH1PN8eAVEoevqHZwB+uz3yXNdIEi4EQLrET5yG1pT6rCcr?=
 =?us-ascii?Q?IL/aLIRi9JTTu/46GqUPM4IzApMF2zywQ4/V+7tMjle+atkYatPZY+Dm64c3?=
 =?us-ascii?Q?npVyVP6In0oH2qweTPpdqNcWHp/EO16PL+gSc4lBrWDMZBGmevIFRFYPFpBd?=
 =?us-ascii?Q?D6uNsfilnM/Ff66QF+x/SNkfHWhKY1EFqXJWTGMvqbh8bB3nmyaguPI3Lhwz?=
 =?us-ascii?Q?kjNxjYjJy27sQdbG1SBk583VXDfuLY46aF7i5Md8+APsOfiij8hDdNExAXoh?=
 =?us-ascii?Q?4q7VOiD/4BWZbubyLY+0ZUie+kleBncSlqzVNXx6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fd22c1-b1cb-4da4-c69e-08daa15b5aa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 14:11:36.0837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3u5YWA371ZLZaWJw+OE91YEI+1hbKQuJA0oNdxxplUozmDB1tNpogPAtjJ/W1Ys543SqGd/Moqp473m4opqMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,=0A=
=0A=
Thanks for the review.=0A=
=0A=
On 9/28/22 21:45, Greg KH wrote:=0A=
> External email: Use caution opening links or attachments=0A=
> =0A=
> =0A=
> On Wed, Sep 28, 2022 at 09:16:15PM +0800, Wayne Chang wrote:=0A=
>> From: Sing-Han Chen <singhanc@nvidia.com>=0A=
>>=0A=
>> Firmware built for Tegra doesn't support UCSI ALT=0A=
>> command and has known issue of reporting wrong=0A=
>> capability info.=0A=
>>=0A=
>> This commit disables UCSI ALT support when reading=0A=
>> the capability on Tegra.=0A=
> =0A=
> You have a full 72 columns to use, no need to make it shorter :)=0A=
Thanks. I'll update in the next patchset.=0A=
=0A=
> =0A=
>>=0A=
>> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>=0A=
>> Signed-off-by: Wayne Chang <waynec@nvidia.com>=0A=
>> ---=0A=
>>   drivers/usb/typec/ucsi/ucsi_ccg.c | 16 ++++++++++++++--=0A=
>>   1 file changed, 14 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/=
ucsi_ccg.c=0A=
>> index 5c0bf48be766..fde3da0605f5 100644=0A=
>> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c=0A=
>> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c=0A=
>> @@ -122,9 +122,14 @@ struct version_format {=0A=
>>    * Firmware version 3.1.10 or earlier, built for NVIDIA has known issu=
e=0A=
>>    * of missing interrupt when a device is connected for runtime resume=
=0A=
>>    */=0A=
>> -#define CCG_FW_BUILD_NVIDIA  (('n' << 8) | 'v')=0A=
>> +#define CCG_FW_BUILD_NVIDIA_RTX      (('n' << 8) | 'v')=0A=
> =0A=
> Why change this here?  It's not needed, just add the new command=0A=
> instead.=0A=
=0A=
The change here is to distinguish the FW built for NVIDIA RTX products =0A=
and NVIDIA Tegra products.=0A=
=0A=
#define CCG_FW_BUILD_NVIDIA_RTX      (('n' << 8) | 'v')=0A=
#define CCG_FW_BUILD_NVIDIA_TEGRA	(('g' << 8) | 'n')=0A=
=0A=
I'll update the change if it is not needed to do so.=0A=
=0A=
> =0A=
> And what commit id does this fix?  Is it needed for stable kernels?  If=
=0A=
> so, how far back?=0A=
We are now enabling the NVIDIA Tegra products on upstream kernel.=0A=
The change is to add the Cypress cypd 4226 support for NVIDA Tegra =0A=
products including Xavier AGX, Xavier Orin and the upcoming products.=0A=
The Cypress cypd4226 is not enabled in current kernel codebase.=0A=
And thus, we shall not need it for stable kernels and backporting, do we?=
=0A=
> =0A=
> thanks,=0A=
> =0A=
> greg k-h=0A=
> =0A=
=0A=
thanks,=0A=
Wayne.=0A=
