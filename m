Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2632692E78
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 06:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBKFHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 00:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKFHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 00:07:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCEA2D76;
        Fri, 10 Feb 2023 21:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676092067; x=1707628067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4PRZoGNYL7C+uRNqlMMHPzT3A9ThjDlbbZUALNVQGLc=;
  b=hIJMErBxt9ZS8ngKhvJwX0Fo0GKiGfXEiDVy2+97r7jN1IH/49LD0WwY
   +aq1FFOuPpMSlODJAuTkkW6I8LrTc5JBOH5y62FTvTGnZNST9PqiJA/YM
   4nUTEstR5S4HdsCw2ntRmFUhNfI3w5BuOzYVUNyWSudTh6rJ7KxFWqXFN
   MRpfwuzlmRitZldk9VEODGOqiZFBGptDhFeX2LR2iSmiNtP8erK6m8C6m
   DoqntX9vKT/QFIitITapRm+D7cCUlp/sn4ImG0YjFT94t45kZs/bpB89y
   lYSvapkObdJKVzHZS3KdU0LZ8/EK/aJIYXbJVK6pmyHEU+bDt9tozZj91
   A==;
X-IronPort-AV: E=Sophos;i="5.97,289,1669100400"; 
   d="scan'208";a="211526243"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2023 22:07:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 22:07:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 10 Feb 2023 22:07:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJTMaa922AqqENrTklxA+Zvdc5xRwJ6wpHnBfq4UvNPW6VE5whcLGgC4rU0iStSvxeyafoXGCoHKsL77CrWqkI1sj7p58M8SHETKVcrWAbP7zMisBVMH1nXDwcj7nXlJ+NfdAZWH4fOq3Q1ZSo98yBOFfROOolS4wPN15FvGVUeNa0/6UpoU1Waj/axOHX1VzmnhgRPynVd36I6kkDliiUB9nwrVSe8W+OgIvivHoiHaE/Gahfwq4FVu1gLeY0uiQ02p3smgEGCZWxpaCR+PKUXe4A6GSzBQsyuPoEhYKWxrd2GcVEEwUkvk1JyhJpF3ct1RM6+nSfqCpdaiiJa3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/QT3Z/3RG8yw2MFshFfaS49Mdp/Y1WKqDXysDRCtro=;
 b=MTSGCUNMl+hhya7AkNiD5eal80pQ/gTlFF9NRv/igh0tYxGyBix0yqOddCZZfPgMbFWMK5JNXplTx7Jw90XqkgKqLKAp8bqKvSKR5OztDVnNEZC88W/MmWbzMjwF+9xAuQW3k39kW26J3JZGHd4JnlWMwOu1GpAtrtGEtEvTykVF7lSMHLHWOeWFO3Iarj5oKnFwFuX9eWq40qKT3ZUi+j3PtqS6HeNqgg3aZZL06AJ5XNleyMb4PSXKNYS0utePuxhrYceVdp6tHMYCz07wCj2rLxuOqlMfdbo9bCm+r0ZOCAnz/kxJQdZw5K1teAgFsQBpciEQZytRBST6rR9JBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/QT3Z/3RG8yw2MFshFfaS49Mdp/Y1WKqDXysDRCtro=;
 b=d0OAaawft3WC8HZeWBuqhhh+SthtXc6fnVO3O/DoWNlhEehFnu5wCTwN3iYyQVDf6TmlHuz88YqDC4Z2bBUzsH1kBHmJXlm6/Tj2x66DxB1cMvnd4qELqEvYyMwX5cQ9TyW3hTvnewDR6F/CRniaAI/xMZEoTNyJh2yDhXAqOa4=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by DM4PR11MB5438.namprd11.prod.outlook.com (2603:10b6:5:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Sat, 11 Feb
 2023 05:07:44 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6%4]) with mapi id 15.20.6086.017; Sat, 11 Feb 2023
 05:07:44 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v4 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v4 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZPED0IEC8iEmq9kS9Rw5j6ZWLp67GT+IAgALkDmA=
Date:   Sat, 11 Feb 2023 05:07:43 +0000
Message-ID: <PH7PR11MB59588BF687D7D2EDAC36E4899BDF9@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20230209044237.3927293-1-tharunkumar.pasumarthi@microchip.com>
 <Y+S05tQ5e5pE9/v0@kroah.com>
In-Reply-To: <Y+S05tQ5e5pE9/v0@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|DM4PR11MB5438:EE_
x-ms-office365-filtering-correlation-id: 5c59ed1a-4685-491e-c046-08db0bede884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4IvWTsTVdepeoqEe2tM/W3Ye7Icx58MANfdXWl8qZdt3TtIeWJpTuhNRPc68bajjTwRP+ZuYnuK+6tQns/yqkH7I2Ycx+uoqe28llmuPTI8lj3vml5kDkRT0qXyhJ2JzRrJ+QddtwEQCTEgJ0Am9/g3+xFiTD6JI8B3bkX2yxswQ0ILRb+tzz+TgPjkPbwvRTiYQRSxgbZZau9nVkeeCodmSSUpRURwfuSYru7ZoTWpzUovC6CqziQ82lgH5ZMYyOY390ba26M9kVQVGv7nf0rMCNk+C/eSDJ9xxasZ6CYavArgT5xs5xXjpy8X7kLd9jiLZhoyY1y1vomyF90wrwH1GF7/VZUVIloRrZDUPTMIUf9jRX0FqENfDma9mXQ+dI5udiKYoDlukLEAMWUJ68zaMKBPmi9Wpiyg1S8FBR9vWdUv5iYSDWsLtGfS/EX1PEs0/h57+fKIDGeBWaB+T3ourp1zxPdov0HLUPvJnvJXE+zrE7bikroEwjA1flzLuMQ7nPS9vPfgAfelwf9VgMJnZIo2kMv7l4LB1IjNxuOOYHvdHVI7T9I7jb1KgBnMahn090+z2s7ufLnJOUlzfXVZlBc7K/jDYcoGQXlE9AUFbpeqLuxL/BaCCeqtsUJy1wWl7oSqxvDMZHruJi6+f2gKoP4tDfHvEdkhtxLxW90saZGURZE2sAHY2wU28WEAG8PTssqF9OHxxMuJIcIGfpEg0mgYfMMC4IEoR7LbIiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199018)(53546011)(186003)(26005)(6506007)(107886003)(9686003)(33656002)(54906003)(38070700005)(83380400001)(7696005)(71200400001)(122000001)(38100700002)(5660300002)(52536014)(8936002)(316002)(2906002)(86362001)(478600001)(4326008)(41300700001)(6916009)(55016003)(66556008)(8676002)(66946007)(64756008)(66446008)(76116006)(66476007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l/B7nrZGdWkJlH7nuLxkBJGGPCxZQm8wfLLPT21AmXdJrKiQA1MrGkrpwFjx?=
 =?us-ascii?Q?OihVQjSf6cOYsIAEhyF7NnrMPP8XOch9osyzeVr4UyI9QlInZkIlqX+yNk5t?=
 =?us-ascii?Q?+dErSlH9HGQvfuGXlyW4kvYzAkvKonzv0opr9tnNZ/YbVhtCIVPiNa3+1pI1?=
 =?us-ascii?Q?G2LY4f4m3Y7aO4PV7k9Z12yzwQBFvJpxf5u/+FxQTMEOI1NXZD8ui0+i0Edw?=
 =?us-ascii?Q?zAmM8qN/Wk11rEUhOu+yKd2QmIGr+7gfrGdPu4ZfIOKluiPH+h1sO5axYTEI?=
 =?us-ascii?Q?6RcwV1aVuVUVyMqoKXu2+udi2hn4ucgNrPi+nzB+JR/wX2sUIkKc756twr1Z?=
 =?us-ascii?Q?JW7q6qUHHdhNy4+IJQd37mOkN06H7H5rMPeG1YCRPf1IvpYQET862SUD2itc?=
 =?us-ascii?Q?Vjvwqy8aHI+CSEbOP6Unw8cJus1vvmO6dvTftqxVEjmGjeQpD678k+g1rWOB?=
 =?us-ascii?Q?hCavScgsaEQIwUCY2TUIIbwUTstEitjLx9ehGRDXz7sARpXEumVVkDfdPvHu?=
 =?us-ascii?Q?EWMTdWW7PFg+xc0yEaWL8fyNnkrrY3HiGPnoDkrlSJTPcKozkqgEA4RRYz7r?=
 =?us-ascii?Q?yvUOxe71LuJMmkmsQE/ZkZ9YE3H88IQpmAQEx6pJhD+0Hj+iQ6hnD51GbUwN?=
 =?us-ascii?Q?RRmE0feGRu90Sq8NL8mqms4UV5NILEucv9bYYe8RM5xN34+dfO9xAeQ5bfTo?=
 =?us-ascii?Q?PrbRn4CGibIJmHQDTu4ZKQFbFGOmrXU7EMc5wWBapCF4tHuL5MHCPrWuBhuz?=
 =?us-ascii?Q?k5ztytQiP72pAd1sC0Lywr1mdBFXaUF+5XgcArHLi1xVA5vixObL8+O2rOkG?=
 =?us-ascii?Q?Lz0gzC7oWf633fuwaCLoxs6gWl+LuuyuEawlr6Elycfsh6xOjtUs6cOn3EXJ?=
 =?us-ascii?Q?6rFM5VW9DFORpSjW08/OGXunndDRCk3VLVH5xAOVmIULQ8wwOFq0LGYMMm+c?=
 =?us-ascii?Q?+KoeRbTNNqhRohHJnjeOzCKt1eVvWroydaKIS8IdoHiMYlMXVKIRPtI76ARd?=
 =?us-ascii?Q?xQ3h8ShvH3YLjG8qgJbixO1wA8Vv00Zm8nQ3fVhGOhY3iCVWzW2m+pk+Ehj9?=
 =?us-ascii?Q?U2/VqsmKLLo/915ltIMXFDQ38J2iVQEjXmCJJxaJ/H429sF5qa6KxseqSniL?=
 =?us-ascii?Q?Ct37Cnrmswn96cvcZlZuhp6wBakCC9Q+3L1SvgCHtFNKF/IYost7cn6l9DBt?=
 =?us-ascii?Q?rQiEXgp15bW92OWug/o4Lc0uREHkx5qdjFgRDDX9Jb5dNFM+zz6qUDlr2NGi?=
 =?us-ascii?Q?qAN3p2ht849QViqNxOXTj413R9GkAXn2dOjFNSgX/UZXHNuzR6DqnPk+hUYf?=
 =?us-ascii?Q?9QERQli/WtIaNRBE7v4yIqzqGSd9Brb+reQ0N5MZD1QNDQYFFH88ghSMbcHs?=
 =?us-ascii?Q?Q5KXJj+cozu5HMlO51rVg6MJVU1/iqewaFK/mBy1crvoW9VF2wVkLPXqPvrv?=
 =?us-ascii?Q?Qbjoplev81P4L2ym6x91ZmS8KYjBM9bv54VbtAcMRCFw00oHymNbW37yqanJ?=
 =?us-ascii?Q?8XrfJVmizo0jF4PY4X+S9OXs0CgF0hyvU52EtQwTvTrPvISJnbFRZfIxgVdN?=
 =?us-ascii?Q?biYfuIq4r4eOFVQCJh6Nj7hrWaBBBGkoS5IGtQFCpDpzWYaRdUaFgFASMukZ?=
 =?us-ascii?Q?JK5x2eJKBDEvLAvcV1kuMZE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c59ed1a-4685-491e-c046-08db0bede884
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 05:07:43.8757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9M4ZQ0759WXc0G3aXAyUqlJ49077pgNHRAHHwOEghFHwDPRsHUJbwyJ0iWssnFgd766HKOxl7foGlmYaiChqkGSgxL25w3UWKoKTKuSz9WTV4Iv9kk6Ff3XpQG1BABLb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5438
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, February 9, 2023 2:25 PM
> To: Tharunkumar Pasumarthi - I67821
> <Tharunkumar.Pasumarthi@microchip.com>
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > +     } while (data & EEPROM_CMD_EPC_BUSY_BIT);
>=20
> That's a very busy "sit and spin" loop here, what happens if the read of =
the
> bit never actually succeeds?  You just locked up the system with no way t=
o
> interrupt it :(
>=20
> Please provide some sort of timeout, or way to break out of this.
>=20
> > +
> > +     if (data & EEPROM_CMD_EPC_TIMEOUT_BIT) {
> > +             dev_err(&priv->pdev->dev, "EEPROM write timed out\n");
>=20
> How can the timeout bit happen if the busy bit was still set?
>=20
> And what can userspace do about this if it is reported?

Hi Greg,
If EEPROM_CMD_EPC_BUSY_BIT is set for more than 30ms, it will be cleared au=
tomatically by the hardware logic and EEPROM_CMD_EPC_TIMEOUT_BIT bit will b=
e set to indicate the timeout. User space application will inform user abou=
t timeout on EEPROM write/read when this error occurs.

>=20
> > +             return -EFAULT;
>=20
> This return value is ONLY for when we have memory faults from reading
> to/from userspace and the kernel.  It's not a valid return value for a de=
vice
> error, sorry.  -EIO maybe?
>=20
> You return this error in a number of other places in the driver that shou=
ldn't,
> please fix this up.

Okay.

Thanks,
Tharun Kumar P
