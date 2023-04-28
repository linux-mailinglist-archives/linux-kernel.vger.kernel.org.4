Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9E76F10A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 05:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbjD1DIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 23:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345010AbjD1DIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 23:08:16 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E7340F8;
        Thu, 27 Apr 2023 20:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682651293; x=1714187293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1xlKycH5skREuVwlUJhIILg2pwQKMeRk9/oH7Ft/3f4=;
  b=Y3y9zIRMGwhgp80H66t8GNdPHiyKVUPZBqYjZdiztLwVWUjjlZJv2NIF
   fP129fga6U2u+Sktm/SrlPjt47xMHwtKyV9L7iZv5E3tzKFMpyarWqFGM
   Qx6jXhS380snuBeecKCbE1+BiThMDWOWDnLY+GLZZesGYOA0sagFgEexl
   /Z/l9Qzfwuso8+NTZLYn90ZK8jng3RYRhSXrrKWVFQrESPLX98uArMbM6
   mm6QshhNlFOmkI0N85UZXMz25tS5fD2JMPBDhrlcfNU5T3kuesRc6RhW7
   UFj1LCPKkc7Xt3nVghDNtG1/FWrag9gpznixyuIoyIcAMksmgIonQpy2h
   A==;
X-IronPort-AV: E=Sophos;i="5.99,233,1677513600"; 
   d="scan'208";a="234439783"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2023 11:08:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRhYtg4oKVnur0+QxzpKkpFg6YxtsBVzyvwVjDGTnGkRGIdrqc6KqM9Pl0D2+JEW9m3/2qCW50//7hujdrY3Iqm9YjKaoh05AifriaKjYk09cY73/lT2jYEF5QDPcuiFqTgsdx7VDBQgGmIHkHiPOhqBDdFcDvp6P/T0zL1sfC9ej/8YAw7vstBwLtSOM1DTW+xs+wP6K7nbctAtQ9I2EY/lShCm9Ns8zDYuRocreu1rdYmPAjIf5sZFll8F4RG+XJ98PlhqJSEN1s6R1FzBsMpXvgkKRYJqYGE8aCEWRp1wjx6dKfRS99/f22IVCH2Egrq3HdY3qJxo8b1lVqG46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZRjkcvDEmqnifEn7cXXn/1+OXs1PsAQ1VLtLEgyx/Y=;
 b=CumsDMlxyPpR2NO4WAcc2KhF5zpXcA0Am5FuJpNQkZLfJ1Iwb/rDfJlc5NzG3mZ6OYvhslJhXGY1uMdANJJLSvNtPTRaiGrOEKU6mSDDupoiEAdI45KFMPy4wPiFHxpEG/eNJRYzVueN7WxXk4h+6w1tpZWfdglTqb/p6eviBqnQ4DCcxDmzi9VrAbO+rZZ8tJ8yrV3IJNKvf4naAXFhqfxyt53Ir656QQjtJcfjcd3GTGDYuVCJSL8WgI3+pzjtXkinrMPkv6+s/ac8vzzN29ApwX8EzcXYALGqr0kt7UXpvDT9ddawIA0xNFyQZAUFoAC3e1UcxLHeXjFATzkEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZRjkcvDEmqnifEn7cXXn/1+OXs1PsAQ1VLtLEgyx/Y=;
 b=Ua6H80ggFcZl0VWv/F15LcUfNxcEqYrGBsRBL6kgnsE/68+TncmEW8FejWjASJNz1AF9zegPOtBCt1ow/gDa/aKe5MqoeMT0tl9bTS9l92GyVlirL7FWBDYICCL90vcXn3+S8ItHy51nMQw3Oc4N15Dm4NKSIJVbROMpyhbNfVk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6636.namprd04.prod.outlook.com (2603:10b6:5:24e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Fri, 28 Apr 2023 03:08:10 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 03:08:10 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 5/9] nvme: Make test image size
 configurable
Thread-Topic: [PATCH REPOST blktests v2 5/9] nvme: Make test image size
 configurable
Thread-Index: AQHZeX6p/nGatdyTKEOrLGWRWqbWOw==
Date:   Fri, 28 Apr 2023 03:08:10 +0000
Message-ID: <4bajt3jkx4llds5vqbjjn2huhznv6pwhuzgi76w5wvk2c6pjk2@2227iivksmvk>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-6-dwagner@suse.de>
In-Reply-To: <20230421060505.10132-6-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6636:EE_
x-ms-office365-filtering-correlation-id: f9f75ace-04d7-4734-5515-08db4795cc2c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oq39Pjv68W1PeIp+1YRsNlT9wrtEz1/1rwN2SBt4sAAtocJR5sJk2Nr3YyqH6El9zb5OD/phlNVZn3S0lCQBPCwoN/AEcxknuz9h+DcQ2loaebck0m7Eq4iMKi6D2fRuOJZSiELJdSoLvTq322ycMtmBsToxCcWHW0onXxOVAcJNLuW3uSsz6w9eX4W/M9rlOGYYigIV53Qvpp/kVOUl+Oxl+d4B7Pc3nXL7HWrjywaRf4DXLtEyvFpTRwIK2G6ZP7eLMz17Yi6tOpW1YkHb6LKd/15wdmw1dZKAc9uT7kDJwtT871xqhDT17ZXchU8uZeH9ZVjEVDjQW7L+aTgqzQQzaSGSD/NET09hG90HJs1MEznlD1tC1IuxMcoAp1do9yIesKgLgq0nXXUKK0IJ45btlxgqz5pxVZGvz7FjbKSqTYwzLWpZjxF0iZScxwkpGdObZRYKfiW+3rnuLopGi9aFk2vdB6OgXHXxgT9yj0zREol7d3gqiQ2dEu6c4/6obVif+SNQsjHC8LJkEQeR5cpRgL1ZvL5OHez5xdu+eMLf48j8lKK1/UUHwTRnP1n33+9dZD+SXlrIm1+9HrUXWdXREQnMQzQA5ZuXR2enfyMzLjKVcpgblI4aoj1wb8pa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(6512007)(478600001)(82960400001)(91956017)(122000001)(54906003)(26005)(186003)(33716001)(9686003)(6506007)(6486002)(71200400001)(83380400001)(30864003)(2906002)(40140700001)(66446008)(76116006)(316002)(5660300002)(38070700005)(66946007)(66476007)(6916009)(44832011)(86362001)(38100700002)(66556008)(4326008)(64756008)(8676002)(8936002)(41300700001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WHtEgUJRozbm78fJ9OMFyBjkM7UC1qUf15Yz/cg2PUNT0eDoZDyiLLnvfqDV?=
 =?us-ascii?Q?W9A/u0CJGClmgUWjkcjYHt/65V5w7q/vdEqTDaN/DSeksONPYafDM2Sq/DXU?=
 =?us-ascii?Q?fY/eXMeIgfCECWwlTk19LWl4YzSfWFPwYMKbNY+qo7Icr4GTMbXAu6BTpB9k?=
 =?us-ascii?Q?tkY3ueITyXRKwNRDAs1s3/u7wo7ai48zsdQ8CE9yQbj63lzTCQ0b1Uee3BOU?=
 =?us-ascii?Q?MMGwob9Lbuva5zYnT+bYuWUW9QUkk4AuX3npNBz9TCYLkB12QTsmiyqh5y6L?=
 =?us-ascii?Q?w8sik9aZAXFgLN16Wwitb9rC3SWPcWEkriPzFCiH1+Fffy1yVt9opr1CrdJ8?=
 =?us-ascii?Q?jvQoUvDaz/FBFhUyr/7eDSVAMZIbGwMCzyPnF+M5cLTJJtuMQ+qDzyBYRTsv?=
 =?us-ascii?Q?OB18VrzskihNDegYqaY3viwqT8WQfJOa2kLOhAa83/xCYZSVBztULXNoAqnz?=
 =?us-ascii?Q?LeTz47H8NYgUnto07FiEvkLUZDhZmfOaDNRq7efj+Q5Izz0YgBZKgZeN1pvl?=
 =?us-ascii?Q?7UBU/hZF+//vgv93w09Ja9LKzhPxomFAidn5PCfg1im2Gqu575G1K92lKHKK?=
 =?us-ascii?Q?H2SG0poZWc9ufVuFTvtlcJGTFsaW/C2z64DHuS5V+axdGUKVqJUHa+dhn9PL?=
 =?us-ascii?Q?8f28vvvfGlA3wGzzYDow48tvsLCNOYTNbu1Bzs+0Q9lok+hPSMky1yVkHYOY?=
 =?us-ascii?Q?MacHat6+7pvEN+znLuAQg4geOncoLAdn6pMWqRFn7w/JyLnPDmPnXwHBYYKE?=
 =?us-ascii?Q?9OUlIqCBImMczqVi3AcNr0caeIs9LC6CXGl1ezcMwTKKCUY/JGS3vZI8dtGQ?=
 =?us-ascii?Q?HIqC6+1QgIE9pEGoNACgjZc+2aSWcUnbPP1y1x1cS3dH7tuuSnh2FRk3xMNe?=
 =?us-ascii?Q?T7AKhaOpf2w2blizny8RoZqJYEhyhDZ+PPBbXdG4JwnVmNtnxNpm/CVoWaAb?=
 =?us-ascii?Q?9GUQTj+YmrOj6b4Vm+W8DWK4brQw5DkM4DxjovK0OxgKlCYYoe5ce4G6QmdD?=
 =?us-ascii?Q?HdSMWtbVojyZv41lxFVxtpV5OEuc8nsEJpagAN0oOwr2Ea956qxsW+nCHlQT?=
 =?us-ascii?Q?jgBpzo3cA6GxJ6r0286uOpSGXU0DIuY9nHowtKHNUgiMHxO0fFtBLxZlPXnd?=
 =?us-ascii?Q?G4qIpZySQWnWqth1H3Nxwkuals5hThGXfSvlSyM8SCxI+7mZW6isdXejp5OV?=
 =?us-ascii?Q?S50NM5cEbbzYQSMKoyhg5O2rfxxtQDVRD3HA94Rt5oWZKbFU227fVzQIzKoo?=
 =?us-ascii?Q?kirF2rSUZHFA5/DBltHKh7Z8U6Y//k31Nj2FBEc3KpBUix2rR4PN38tDWOJb?=
 =?us-ascii?Q?0VCs1tfZSv+P7ulplr01RrURH8chQ9VutTX5RkPpARz5JlsKVzA9GuVFO7ss?=
 =?us-ascii?Q?An2hcxQ0RhhblgiXFs9X113MY6xevGc1VXM504Ysea9gEMhlfQNBrabV+1Fk?=
 =?us-ascii?Q?MXeVLkqHvvSqHz9t3LKiYOGdMvdwFopH2gaMIxiMQwu3LPEMTkYizA6BxsF8?=
 =?us-ascii?Q?3G1rKboEhMv1XFl/Y2jtOjwZeo/pvlWwTJrdyLa9uzOLZ2SqUE65MTpNWFYm?=
 =?us-ascii?Q?hczI5jo/Lbxu7iWMd9S5TShe7BpRNI918JAUrlB/X+lwmJb4pHzk6SEKGVYO?=
 =?us-ascii?Q?361auEABVhGYfHM+LW82KoY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36F2D1CB6E716346AEF4D5FC48F8E692@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l/nxk6vNDcf81Q+X8akxweFfW0Rt+paNlbACksBxjFmPeK8/Xl/4eIebonetQy80o+7XiHsPpDHB3jWqfblS8K3o3Rli9pvUQbf9nOBC7Ib60AT4FAyhBJmVdoowbJAmvxDf/E3EPR7GjiEc+Zj17tqE8Czktwabe2LNopm3mmQSuVBC/YBZmS19kAo77vCHst1AR/CHu8ivLds5qSArhxV5bEvur9J9jj19tOAOX6JoiyRiWUMsAWAT6wc0BbTdZ4wEVSoPdyxZ9Rldwm2caPHljfReDPS6f/Hslu8ma/SUPTQkZTPxBHld9BpTHT+dkXrrxmlhDWI7+EUfeos8Cl4rHj2aLgcFy3JcFeElspfWUXJIu5NYMpbuqr3ocqcKVSdDSvkNzOh8e1UK7Uce6tXr4D9tZEo9/G+g10y4oo7nt8N9//c4clCCQkHl4s/ZiU7EnPeeYj0daOT5jaREOH0X3V/EdanAvkkQ346/pgV14XlqeOjQidIXauWbcBx9DY8oUAnQ8k3/C/PIbbM3eqHVmvHMnxAKKG1a8vgV7U4lqbKMvwulDB6HCuQEsL1myWDp8vSblXRX377QfNbyS1RNDCRggkL2BjBj63zwVWDqf1XIEGCl4F3GZ7auUdB4Tw0PIoKNJ9bHN/fTmg98JxZQDm+F9GzDzobMr5dsfBYR9j8mxANwa2RLtehw28sbFIq7dPv/n3lq3Y+zkuPx0bXZ8zVNAmkteepvKkCsmdzSvx7LadeC361g6VrpUYO/RY05untgLomUOt66t9VK44oJGZuR1Ro6YfkWt6YXQ9BEClzrRGIWtjp1Ubl8a+bI9+peJHaZBtpERSfrjEre8cEFwbW56e+eRhMZOwZXla2Yhg9ZT4N8T2q9XF7ygOFo8exFKHHV1BUrFzPoDSFy2twmDG2+paXYr21LEN4cDSA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f75ace-04d7-4734-5515-08db4795cc2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 03:08:10.4134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pdsa/Na1kmWpSWHbuKFlgCAzLDCKRI9LsBRyQso9iZ9g/LnnM9rFpvuZxQVzk+w9TwG1iNhWTtG301vVFzSsI5jfGxR8mP2yUWEaeQuKBwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6636
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 21, 2023 / 08:05, Daniel Wagner wrote:
> The reduce the overall runtime of the testsuite by making the default
> size of the test image small. For verification jobs, the default can be
> overwriten via the newly introduced nvme_img_size environment variable.

Could you add descripion of nvme_img_size in Documentation/runnning-test.md=
?

   I've noticed that tcp and fc of nvme_trtype are not described, but this =
is a
   different topic :)

>=20
> The default size of 350M is the minimum requirement of nvme/012 and
> nvme/013. These tests rely on an xfs filesystem which requires this
> minimum size.

I read back discurrions on the v1 series, and I'm not sure if it is agreed =
to
decrease the default size from 1G to smaller value. My understanding is tha=
t
Chaitanya's points are:

- Let's keep 1GB default size for consistency for blktests users.
- Introduce nvme_img_size so that those who needs faster test run can
  set smaller size.

>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/004 | 2 +-
>  tests/nvme/005 | 2 +-
>  tests/nvme/006 | 2 +-
>  tests/nvme/007 | 2 +-
>  tests/nvme/008 | 2 +-
>  tests/nvme/009 | 2 +-
>  tests/nvme/010 | 5 +++--
>  tests/nvme/011 | 5 +++--
>  tests/nvme/012 | 2 +-
>  tests/nvme/013 | 2 +-
>  tests/nvme/014 | 2 +-
>  tests/nvme/015 | 2 +-
>  tests/nvme/017 | 2 +-
>  tests/nvme/018 | 2 +-
>  tests/nvme/019 | 2 +-
>  tests/nvme/020 | 2 +-
>  tests/nvme/021 | 2 +-
>  tests/nvme/022 | 2 +-
>  tests/nvme/023 | 2 +-
>  tests/nvme/024 | 2 +-
>  tests/nvme/025 | 2 +-
>  tests/nvme/026 | 2 +-
>  tests/nvme/027 | 2 +-
>  tests/nvme/028 | 2 +-
>  tests/nvme/029 | 3 ++-
>  tests/nvme/031 | 2 +-
>  tests/nvme/032 | 2 +-
>  tests/nvme/034 | 2 +-
>  tests/nvme/035 | 2 +-
>  tests/nvme/040 | 4 ++--
>  tests/nvme/041 | 2 +-
>  tests/nvme/042 | 2 +-
>  tests/nvme/043 | 2 +-
>  tests/nvme/044 | 2 +-
>  tests/nvme/045 | 2 +-
>  tests/nvme/047 | 2 +-
>  tests/nvme/048 | 2 +-
>  tests/nvme/rc  | 1 +
>  38 files changed, 44 insertions(+), 40 deletions(-)
>=20
> diff --git a/tests/nvme/004 b/tests/nvme/004
> index 9dda538b1ac0..cab98ff44326 100755
> --- a/tests/nvme/004
> +++ b/tests/nvme/004
> @@ -25,7 +25,7 @@ test() {
>  	local port
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> =20
> -	truncate -s 1G "$TMPDIR/img"
> +	truncate -s "${nvme_img_size}" "$TMPDIR/img"
> =20
>  	local loop_dev
>  	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"
> diff --git a/tests/nvme/005 b/tests/nvme/005
> index de567a74a891..8e15a13f3794 100755
> --- a/tests/nvme/005
> +++ b/tests/nvme/005
> @@ -24,7 +24,7 @@ test() {
>  	local port
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> =20
> -	truncate -s 1G "$TMPDIR/img"
> +	truncate -s "${nvme_img_size}" "$TMPDIR/img"
> =20
>  	local loop_dev
>  	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"
> diff --git a/tests/nvme/006 b/tests/nvme/006
> index d993861c06ba..ea0db93791a7 100755
> --- a/tests/nvme/006
> +++ b/tests/nvme/006
> @@ -24,7 +24,7 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	truncate -s 1G "$TMPDIR/img"
> +	truncate -s "${nvme_img_size}" "$TMPDIR/img"
> =20
>  	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"
> =20
> diff --git a/tests/nvme/007 b/tests/nvme/007
> index d53100f3ff7b..243a79f5a254 100755
> --- a/tests/nvme/007
> +++ b/tests/nvme/007
> @@ -25,7 +25,7 @@ test() {
> =20
>  	file_path=3D"${TMPDIR}/img"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/008 b/tests/nvme/008
> index 5568fe46e463..5abc4240ca46 100755
> --- a/tests/nvme/008
> +++ b/tests/nvme/008
> @@ -26,7 +26,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/009 b/tests/nvme/009
> index 2814c79164ee..491d3c809ab0 100755
> --- a/tests/nvme/009
> +++ b/tests/nvme/009
> @@ -24,7 +24,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/010 b/tests/nvme/010
> index b7b1d5188e9b..805f80d40620 100755
> --- a/tests/nvme/010
> +++ b/tests/nvme/010
> @@ -26,7 +26,7 @@ test() {
>  	local file_path=3D"${TMPDIR}/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> @@ -41,7 +41,8 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
> =20
> -	_run_fio_verify_io --size=3D950m --filename=3D"/dev/${nvmedev}n1"
> +	_run_fio_verify_io --size=3D${nvme_img_size} \
> +		--filename=3D"/dev/${nvmedev}n1"
> =20
>  	_nvme_disconnect_subsys "${subsys_name}"
> =20
> diff --git a/tests/nvme/011 b/tests/nvme/011
> index 4bfe9af084e4..da8cbac11124 100755
> --- a/tests/nvme/011
> +++ b/tests/nvme/011
> @@ -26,7 +26,7 @@ test() {
>  	local file_path=3D"${TMPDIR}/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> @@ -39,7 +39,8 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
> =20
> -	_run_fio_verify_io --size=3D950m --filename=3D"/dev/${nvmedev}n1"
> +	_run_fio_verify_io --size=3D"${nvme_img_size}" \
> +		--filename=3D"/dev/${nvmedev}n1"
> =20
>  	_nvme_disconnect_subsys "${subsys_name}"
> =20
> diff --git a/tests/nvme/012 b/tests/nvme/012
> index c9d24388306d..ecf44fcb5a51 100755
> --- a/tests/nvme/012
> +++ b/tests/nvme/012
> @@ -29,7 +29,7 @@ test() {
>  	local file_path=3D"${TMPDIR}/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/013 b/tests/nvme/013
> index 265b6968fd34..e249add46295 100755
> --- a/tests/nvme/013
> +++ b/tests/nvme/013
> @@ -28,7 +28,7 @@ test() {
> =20
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/014 b/tests/nvme/014
> index 28913641ae40..2d00ed392ea8 100755
> --- a/tests/nvme/014
> +++ b/tests/nvme/014
> @@ -29,7 +29,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/015 b/tests/nvme/015
> index 2f7957caac88..3755cdee00c9 100755
> --- a/tests/nvme/015
> +++ b/tests/nvme/015
> @@ -28,7 +28,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/017 b/tests/nvme/017
> index f2a95cf276cb..0248aee9bc41 100755
> --- a/tests/nvme/017
> +++ b/tests/nvme/017
> @@ -25,7 +25,7 @@ test() {
> =20
>  	file_path=3D"${TMPDIR}/img"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/018 b/tests/nvme/018
> index 315e79534348..78e9b2bb94d8 100755
> --- a/tests/nvme/018
> +++ b/tests/nvme/018
> @@ -26,7 +26,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/019 b/tests/nvme/019
> index 4cb3509a12b2..9fff8ccaac9c 100755
> --- a/tests/nvme/019
> +++ b/tests/nvme/019
> @@ -28,7 +28,7 @@ test() {
>  	local nblk_range=3D"10,10,10,10,10,10,10,10,10,10"
>  	local sblk_range=3D"100,200,300,400,500,600,700,800,900,1000"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/020 b/tests/nvme/020
> index 16fdfcc94918..1966d5925213 100755
> --- a/tests/nvme/020
> +++ b/tests/nvme/020
> @@ -26,7 +26,7 @@ test() {
>  	local nblk_range=3D"10,10,10,10,10,10,10,10,10,10"
>  	local sblk_range=3D"100,200,300,400,500,600,700,800,900,1000"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/021 b/tests/nvme/021
> index 6ee0af1fe158..1fefc0fbca00 100755
> --- a/tests/nvme/021
> +++ b/tests/nvme/021
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/022 b/tests/nvme/022
> index 1d76ffa44178..1ff915786f86 100755
> --- a/tests/nvme/022
> +++ b/tests/nvme/022
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/023 b/tests/nvme/023
> index b65be07edc38..90316230a3d7 100755
> --- a/tests/nvme/023
> +++ b/tests/nvme/023
> @@ -26,7 +26,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/024 b/tests/nvme/024
> index f756797d6f29..384a8266e741 100755
> --- a/tests/nvme/024
> +++ b/tests/nvme/024
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/025 b/tests/nvme/025
> index 941bf36f67fb..815223d1c28d 100755
> --- a/tests/nvme/025
> +++ b/tests/nvme/025
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/026 b/tests/nvme/026
> index c3f06c2a377c..d2203f19f026 100755
> --- a/tests/nvme/026
> +++ b/tests/nvme/026
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/027 b/tests/nvme/027
> index 0ad663ace811..97fe70e78344 100755
> --- a/tests/nvme/027
> +++ b/tests/nvme/027
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/028 b/tests/nvme/028
> index 7de977a81213..c539620bee28 100755
> --- a/tests/nvme/028
> +++ b/tests/nvme/028
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/029 b/tests/nvme/029
> index f8b4cbbb9156..1808b7b0edf1 100755
> --- a/tests/nvme/029
> +++ b/tests/nvme/029
> @@ -14,6 +14,7 @@ requires() {
>  	_nvme_requires
>  	_have_loop
>  	_require_nvme_trtype_is_fabrics
> +	_require_test_dev_size 1M
>  }
> =20
>  test_user_io()
> @@ -59,7 +60,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/031 b/tests/nvme/031
> index 4e1798246db1..e70898819a86 100755
> --- a/tests/nvme/031
> +++ b/tests/nvme/031
> @@ -33,7 +33,7 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	truncate -s 1G "$TMPDIR/img"
> +	truncate -s "${nvme_img_size}" "$TMPDIR/img"
> =20
>  	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"
> =20
> diff --git a/tests/nvme/032 b/tests/nvme/032
> index 81e074cc11bc..9f9756b0f959 100755
> --- a/tests/nvme/032
> +++ b/tests/nvme/032
> @@ -38,7 +38,7 @@ test_device() {
>  	sysfs=3D"/sys/bus/pci/devices/${pdev}"
> =20
>  	# start fio job
> -	_run_fio_rand_io --filename=3D"$TEST_DEV" --size=3D1g \
> +	_run_fio_rand_io --filename=3D"$TEST_DEV" --size=3D"${nvme_img_size}" \
>  		--group_reporting --time_based --runtime=3D1m &> /dev/null &
> =20
>  	sleep 5
> diff --git a/tests/nvme/034 b/tests/nvme/034
> index f92e5e20865b..e0ede717c373 100755
> --- a/tests/nvme/034
> +++ b/tests/nvme/034
> @@ -26,7 +26,7 @@ test_device() {
>  	port=3D$(_nvmet_passthru_target_setup "${subsys}")
>  	nsdev=3D$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
> =20
> -	_run_fio_verify_io --size=3D950m --filename=3D"${nsdev}"
> +	_run_fio_verify_io --size=3D"${nvme_img_size}" --filename=3D"${nsdev}"
> =20
>  	_nvme_disconnect_subsys "${subsys}"
>  	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
> diff --git a/tests/nvme/035 b/tests/nvme/035
> index 8b485bc8e682..2c4a25f82937 100755
> --- a/tests/nvme/035
> +++ b/tests/nvme/035
> @@ -17,7 +17,7 @@ requires() {
>  }
> =20
>  device_requires() {
> -	_require_test_dev_size 1024m
> +	_require_test_dev_size "${nvme_img_size}"
>  }
>

This change looks weird for me. The required size of TEST_DEV can vary depe=
nding
on user's configuration. I think nvme_img_size specify the device size that=
 each
test case prepares, isn't it?

>  test_device() {
> diff --git a/tests/nvme/040 b/tests/nvme/040
> index 8d29f905adb5..31b7cafef4be 100755
> --- a/tests/nvme/040
> +++ b/tests/nvme/040
> @@ -25,7 +25,7 @@ test() {
>  	echo "Running ${TEST_NAME}"
> =20
>  	_setup_nvmet
> -	truncate -s 1G "$TMPDIR/img"
> +	truncate -s "${nvme_img_size}" "$TMPDIR/img"
>  	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"
> =20
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> @@ -37,7 +37,7 @@ test() {
> =20
>  	# start fio job
>  	echo "starting background fio"
> -	_run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" --size=3D1g \
> +	_run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" --size=3D"${nvme_img_=
size}" \
>  		--group_reporting --ramp_time=3D5 \
>  		--time_based --runtime=3D1m &> /dev/null &
>  	sleep 5
> diff --git a/tests/nvme/041 b/tests/nvme/041
> index 03e2dab25918..308655dd6090 100755
> --- a/tests/nvme/041
> +++ b/tests/nvme/041
> @@ -44,7 +44,7 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	truncate -s 512M "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"b92842df-a394-44b1-84a4-92ae7d112861"
> diff --git a/tests/nvme/042 b/tests/nvme/042
> index 4ad726f72f5a..fed2efead013 100755
> --- a/tests/nvme/042
> +++ b/tests/nvme/042
> @@ -41,7 +41,7 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	truncate -s 512M "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index c031cecf34a5..a030884aa4ed 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -42,7 +42,7 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	truncate -s 512M "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> diff --git a/tests/nvme/044 b/tests/nvme/044
> index f2406ecadf7d..9928bcc55397 100755
> --- a/tests/nvme/044
> +++ b/tests/nvme/044
> @@ -53,7 +53,7 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	truncate -s 512M "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> diff --git a/tests/nvme/045 b/tests/nvme/045
> index 612e5f168e3c..7c51da27b5f1 100755
> --- a/tests/nvme/045
> +++ b/tests/nvme/045
> @@ -55,7 +55,7 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	truncate -s 512M "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> diff --git a/tests/nvme/047 b/tests/nvme/047
> index d56d3be185b0..b5a8d469a983 100755
> --- a/tests/nvme/047
> +++ b/tests/nvme/047
> @@ -28,7 +28,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 512M "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/048 b/tests/nvme/048
> index b4ee7371eb68..08fdee16c811 100755
> --- a/tests/nvme/048
> +++ b/tests/nvme/048
> @@ -84,7 +84,7 @@ test() {
>  	fi
>  	hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> =20
> -	truncate -s 512M "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"b92842df-a394-44b1-84a4-92ae7d112861"
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 41f196b037d6..e5ba9a6d5f54 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -17,6 +17,7 @@ def_local_wwpn=3D"0x20001100aa000002"
>  def_hostnqn=3D"$(cat /etc/nvme/hostnqn 2> /dev/null)"
>  def_hostid=3D"$(cat /etc/nvme/hostid 2> /dev/null)"
>  nvme_trtype=3D${nvme_trtype:-"loop"}
> +nvme_img_size=3D${nvme_img_size:-"350M"}
> =20
>  _nvme_requires() {
>  	_have_program nvme
> --=20
> 2.40.0
> =
