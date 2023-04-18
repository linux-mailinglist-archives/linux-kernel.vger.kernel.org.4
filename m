Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D06D6E5858
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDRFGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjDRFGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:06:14 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2CD4C3B;
        Mon, 17 Apr 2023 22:05:58 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I2Urdv001690;
        Mon, 17 Apr 2023 22:05:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=fUFbTCsbpwD34ttUos2pWGTWGlgN+Xno1UmdHJgivJ4=;
 b=Mfn5tNU5A9Lu/fs/T2Hu7Gu96fwzPDzAfIq5WsNSodsGTfIBC9KtWkiVq8zikDoK8JT/
 N+J/AQof7ZZEdxoQtH0Gc+0P5MjKeYq9En/uOySxTcskzRqD/MR3ze+wzm1dNtHYP0ux
 Gd8m6ea44k11T2wg0mlXcB2fRcHbJxm/rdrc7RcPYNs1A9hrYcIgZTTyPt8qmxjIBvRu
 8YXTbdp9zobnKhunwkcI/X37IYdc3F+l62XraC7m2IpVLhoXGLDNWIPJF/VV3XVvXZLd
 X0jn0bbX+34vXKAlNCqBlIwvrCopl8jw6b6tW7ky+SGMFFhQVqQrulUOtZlIXlW0CLWZ 9g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pytuvjgdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 22:05:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1681794336; bh=fUFbTCsbpwD34ttUos2pWGTWGlgN+Xno1UmdHJgivJ4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=M095EgSgYPV3gu+q2P9cRE5co5FNOn54Qtc8tmdOMbUcOalAcRxuUk4tFcn/vADAD
         2DOYOFRFK/oV58TvasJpMaxKfCIVRCIVSUjEU/8KjQAy37Eesbv3PKa8sTruGglOeR
         9zO6+G5/l5R+f9G3bE4B54QZG+4ZYT7JRw3ScLnNsxt6iEWXkGjl+kgWgnljT8AKWW
         uFFm7m+LIIjOV5KbFHE09RAfEYeBvvVZkjKiwzxI1iWjufHrkYUIg7ZXENJUHxRo5n
         oqWgeaHfI8pmf+z9icMnl7zh8eYV5o+T55Fe28qnQUvCnXZqHCapAxzSyw33pOMGy5
         NVOMUzjgp/cIw==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 28E73404CE;
        Tue, 18 Apr 2023 05:05:35 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id AE154A005A;
        Tue, 18 Apr 2023 05:05:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=IzssPAKM;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CE30940D07;
        Tue, 18 Apr 2023 05:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMd2e4SzW03uGoLtil0hAmHoLi7pPQxOmi1BI8MdVvNkQgmTufR9fvAGsccn4V0xz6xbQCvLKAI631BAZDu2llrSlPnW0moN9JwWkVohAsBXDz6e+QZHFDfngzgN6nWQ5Q88W0kguDht3avzXZ3sjBJyeO1J66wxuzHTDzu2ZP4bW93ehNgo031UHWs6ewTHz9Vc8tZmnqb5Cd2GK3w5PbI7DuSNkhFFA9SigFEENrnpNm0b/9CDAK24+ExI0YTIYbK3hZTXYkHjR2AU1CWDlKucKHhVl8jDa7grVfsXgN9jHkN8TV51P9grEJlZYiAfz+gdObub0G4P5osv9CQ47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUFbTCsbpwD34ttUos2pWGTWGlgN+Xno1UmdHJgivJ4=;
 b=ClZTNwkCITkccgXK8yv1qzVIuDR4eE2QWxT/PNuL7yJmiNM+Ol18scNaXxoiJ4PQ2T4No8/dMyFmPxA8N7PChHi/82gkCyqWwblQS87e21o87LtgG4chHwbIBr3mvJe8aavLG67QDecBMloQnM9QMN/Jfjusr97Wt9WwzjdATEGb8bmmeTf+OyYXRHjqzez5scJ9b+VTOXUjckdfk8jDP+uIYag26ppk05gL4sGVgKZIwVj3Py4H942yqnO0AM3CnwjH49tRNaz+g5P9omAWu9ao/MwxaSa8HM/R03wuUDf2FBOF+dzVo7pBvERIDF6ZhiGnJtmSj2QQTHRMpYhyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUFbTCsbpwD34ttUos2pWGTWGlgN+Xno1UmdHJgivJ4=;
 b=IzssPAKMFhZWSPy+DlbcqKz1fRFHLS0amZbAu8w3AhC5Mm8lfSlSqqDmRFJ/cD2akAnKXhmOQQ50a7Osahf9C4EAyqmBnsap+7vYrFHsE29jzLXzFA6rx/IchqRITCuTLOFSyVoQkKMdIgf/0/yV7mrgyQznZfCt2uAXOHgMGYg=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 05:05:27 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::2dd9:84:a1cb:ece1]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::2dd9:84:a1cb:ece1%4]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 05:05:27 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>
Subject: Re: [PATCH v2 1/4] usb: dwc2: improve error handling in
 __dwc2_lowlevel_hw_enable
Thread-Topic: [PATCH v2 1/4] usb: dwc2: improve error handling in
 __dwc2_lowlevel_hw_enable
Thread-Index: AQHZbq0XE33RmTqMaEmZZt50sYO6aK8wiWkA
Date:   Tue, 18 Apr 2023 05:05:26 +0000
Message-ID: <e78f13a1-b035-c3b8-7aff-1eb0cd55e977@synopsys.com>
References: <20230414084137.1050487-1-fabrice.gasnier@foss.st.com>
 <20230414084137.1050487-2-fabrice.gasnier@foss.st.com>
In-Reply-To: <20230414084137.1050487-2-fabrice.gasnier@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|SA0PR12MB4479:EE_
x-ms-office365-filtering-correlation-id: ba103daf-cd15-4f71-0e27-08db3fca85b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dNVyA62c4F401jK0EJbf9P2gx9tLYchICqY/wUIvIb5sU40U7/6nd3Rd54VvIJ1NLpg2mj3K3HVhxsCovYkSh+ERR6f8VI7vW0tTSSp5T5OKFKrhCGCDJf5LQKPKa+gDG0hT5083QMRpxiznA9fp5hE7j9wQSwz0YAuEiXGv2sEpgWbh0pvXwmaLsvZ32kQUxT/4an1Z3BhIjMuXB8fR84Jopy614Xr3FHDvSL8clb17DnTVsy+pgczbCwsMUoSQmizRI4cIZtTOHze3ClbwBFpXZg+LBfZXXIN3p5Loz7NZMysCcUXaXm0rv/pleiA9s9veIM2ALggNM7Fv828vnNRpiwmnAhF+6sIcUqTm+f8bCjY9zVnryZHiVtzWtWMBhHnXtmCEolpw/HxV5Qmu+feI7CmpH4Tba2++GrsvaNbdSUIM49TUqR0vLjwssWtClfap8e7xkXM3amNrropuS4P2uNbg5PJHKN98I6DUBZdYTl7VjdJ/iLC7+E5tN7+mBm4eiZCyR1mwZxgtKELoS6wArFAvVOLv6kPx3NpyheOOD0mKVnx91EOs8x9Xef93K9voiqaaiowwLANJN5eP+4rojiHeJWn8IXPmGleaMPiB+zPaLOKIPCQ7ZzwApvqsKuDDMUsAOS1j1uolduaO6QJLia7ywBHVXFpqRNV6uepZtYldQNG15KeCbpfakjfa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(7416002)(5660300002)(2616005)(31696002)(83380400001)(122000001)(86362001)(186003)(26005)(6512007)(53546011)(6506007)(38100700002)(38070700005)(8936002)(8676002)(110136005)(54906003)(478600001)(71200400001)(6486002)(41300700001)(316002)(91956017)(36756003)(76116006)(66556008)(64756008)(66476007)(4326008)(66946007)(31686004)(66446008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW4wOGp3dmdQUkxNbWJzUkNVVjNUVHJlYk9CWlBpNnR5NkhFQjdZdXo4RmRY?=
 =?utf-8?B?K1BQWTU3aGRpTllVVTBCYmYvakU5QlR1aGJrZkw4Y1A4bW52UTEyTitPNW9p?=
 =?utf-8?B?aGF0R3draWZxeS9JdE9wMmkwK09SRDFTdFZvMlBmdURmUnp3M25CaUFiSy9J?=
 =?utf-8?B?djQrSUtpNTFQN0tjQ2V5QzBFTzk4SWNsWEh4b2t4ODlvSU1OdlhXdGlTZEUx?=
 =?utf-8?B?UzVGNzBSTG1WSVY4b2psRjl5L3kxd2hUdk5MR0ZmUThCOGZjUjlRZ2s1ZVVX?=
 =?utf-8?B?QldPY1A3M3MyZERpQTRJdmhKTHdGTm5oTzE0TGV3K2hFTXJHRHdXWEo1L0R3?=
 =?utf-8?B?NE9LUUhDVEtSK3ZkaGhPL0t6RmxXOHJFQngzeDMvazdXYkdGTXVKbUZQVC9L?=
 =?utf-8?B?KzU5QzVKblhCc09tRUliTkgwK3FhYUN0d05QWUs0UG1qWXhIMlpCd0tSYWVw?=
 =?utf-8?B?d3Q0dzU5d1UvNEZQcjI2RDY0TmpZS0hweXFoWlJZSG15WmJHc2x0R1ZFZ0tj?=
 =?utf-8?B?c3V3OVVPcHBkcXRTRnNkTjhhbnRnL0JQTWtQSG4ycVErR2htYnRsayt5eWdO?=
 =?utf-8?B?bU5xVlZIOTQwdlFLelVKbVFTS1YrWUlua1VDUkZNL3ppZjlZY3c4WEQvdFhr?=
 =?utf-8?B?ZlRPejlDNzVDc3A1eG0yK1lGcE5TZVRUY3FxMFlITyszRWNQT2lEbEgzT3di?=
 =?utf-8?B?UmZ2aVJ1UVZ2ZStBVzlYOTIvYWFnbXNucmlZcktuUTE0LzY0QU5sSzlYQUww?=
 =?utf-8?B?aDBFNTd1SXExdEJHZGRQMDd5YXl5eDEwN1hqNXZUQThiR0J0SVNSaVlQYkR3?=
 =?utf-8?B?RFBMSGdUeEQvTTBzNnAwc3k4TWVFVnRicXhOOUV4UndwWGN4UXNTSEFxMnZR?=
 =?utf-8?B?aVN3dG5rWGowT3ZBc1IvZEpKQ1NYOWpHa1pSU0FncS9CK1Z0ZEVzNlZxYWpU?=
 =?utf-8?B?NVZ2cldOdHA0L2tiMmxwak83UEJ0dm9kYytrTTgzeWtvTGhDb0lnVUg0RHUv?=
 =?utf-8?B?TXhpaWNWQ0JsNGxmNUZWZXc1Q0lBMVdCWFJIeXhuK0VnWmF1VEZWUG4yNm4v?=
 =?utf-8?B?bmJTUkZkaUhrV1RDbDNWUnhBSVZPWXY4SnUvckNOYVFMcjlWSy96SEZoalA5?=
 =?utf-8?B?T0thSGhIZ1k0N3g0dEhZblREUU9BMjZ5WTB3MG8zSXVQSFhFdVF4QU9iZnB0?=
 =?utf-8?B?eExrQjJEOVcvRjM1NGg3aGd3SHc5bnZzTHFUMGRqWjdHenhhVUFGOUg4T2J4?=
 =?utf-8?B?Q25sYnR2RUdnYTljeXJpV1hGMk9pblM0bEQrQTAvRWVLZ3lNdE44S1RIYy85?=
 =?utf-8?B?amw2Y21HQ1pVVXZhN1ZSWWZKUGpqYmZZVnNNYVNIdmNMb0dDZ3RyZlNBQlg4?=
 =?utf-8?B?NFdwelYwQUlVa0ladWgrT05hS3hFYmYyZ0gvK2x0bzZLdWo1MlBhUWNnQkRn?=
 =?utf-8?B?b09VN2pzSXgra2J2ckVYbDYvSmJQV2EzTG5XTmtxQ1BHSXpSaW9BSnNWeE9t?=
 =?utf-8?B?bVE5UVQxUE84akdVV3ZjT1VRaGtodlNHQUFoQkRyc0tzWG53VCtiMzdrSEZQ?=
 =?utf-8?B?dXpRRitZKzl4WXNzOUFwV2RzdHhwMGs2aGtxaEVDeGwzYk5hRC8wbjdJOVNF?=
 =?utf-8?B?bkllN3RSYW5BVi9heDdDbGMxbUtnQS9tczhnV2RRRTZDc2lYVTdZTlR4OE1w?=
 =?utf-8?B?T2NmWlU1WXdlNEQzY1BrNFpNdWJvN01mY3ZZa20va05MeWJaL2lPTm5ndkZW?=
 =?utf-8?B?V3RYNFVtb0tDQWwwM2VMYm8vWnBtQkp2cXRsaEhQT1VmR1lNcVVVb2ViZ1hL?=
 =?utf-8?B?RXMyU3VXV2Q5cElXd3FvQnN5a1FudEl4dGJ0bTR4TERLMWY4RVhXL0oyWjhZ?=
 =?utf-8?B?dnJsQkRSWHpYSC8xWXNITlVrb0xmcVg3ZzcvMnR1MmNHWStWVVoweVdjbjNC?=
 =?utf-8?B?OUpCdmNjRzUyTW02a2NtR2t2c2NhNHN2cjY4SEp0cmdleGxSMCt5UURqK21u?=
 =?utf-8?B?VktQMEhLbE9sUzd1UjltVmFDb01EKzhQK0k3a0UvVUM2UHBUTUFiQk80V2lq?=
 =?utf-8?B?UGZNSjVpZnVmSnowV3Jxa3dVa2lUT1NkVitoUDZKVkM5bkxRbCtZcU5aZ3o5?=
 =?utf-8?Q?r3Wvi1ur+RzdOpSaEZ4IQZVN6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A591B5F669257F4B92EB73C9E41991FF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K2NkcDNqTlA2bGVxcjJSc0FFeDd5WTlJWjRtWGNxODRjNjhpM1o1bVNXMzly?=
 =?utf-8?B?aWYySUh2NGVHUDh4Yk96QUtxYWxibmNRZEw5ZG1HU3AvL0oxZXp0Yis2Mm9z?=
 =?utf-8?B?eGRmTC9vSTRzRkpnTTk3ZjFGRDNNTXM5UHBjMXk3ZmpJWjBDc2NTUmUxZmc2?=
 =?utf-8?B?WG9rTEE4ZEQ5SVVRYzBzdEZkOFhWT3NFeThqZXhXNWxEanhHMGltVHRRSWc4?=
 =?utf-8?B?TzRRekEvT1YvQVArVUhUVVAxckR5WFBia2szdlJidE9CVzVsVE55ZTBodCsx?=
 =?utf-8?B?YzRxZjBtQUhxRHV1TTlZODRXNGVKaU9VK2ZRUzI3KzlKTDh0SWljYkJnVnUv?=
 =?utf-8?B?YjlLMDRvK2ZqT2lEaEZQdURrV1lXTkhTRWkwZ0pMODVaZCsxb1MyVXNUUGNW?=
 =?utf-8?B?UTgzdGYrdnlTM1JGeE1wUlFxb0VQQTVrZFJ0VS9EZ094ckM1SmhKb2NSa3VS?=
 =?utf-8?B?eWhFN0ltby9uWG9tNHRURjk2SFF5VjBycHJiSFpRYlFTV2habm9MWFFXTUhC?=
 =?utf-8?B?TFhYcE14aVJINDkrekZqVGsxWFJ0bnBPU2ZMeWx6R0x2NjVxRVB3UFF0dWFZ?=
 =?utf-8?B?cE1XTEFGTjhuTGx1U29wUFlDTzlzUGI1Rm9WT2EzWi9SUmowbjJDeit2RnlO?=
 =?utf-8?B?Wmd0WUtmQjNDODRtTTRad29WSGR1ZldvOHhPMU1aSTRoN3hyNTVLL1RVWi82?=
 =?utf-8?B?TGxjc0VkNDJUMWFhUUdEZEFIMzFsVjVzWEJLRTF3a1pBcmlqSnplTlpUOE9t?=
 =?utf-8?B?RDc2YXUyRlJjWURtZGMrRDhzQnYxVlFPelcvczhYU2F2YWRJci80M0NEanB3?=
 =?utf-8?B?REw2WXp0eXBvTGVhZlhKRkh2VzlBaEcxZ1cvQXlXOWRrVkQrU2d5Wms2aHRP?=
 =?utf-8?B?cWh2cml5a1dZK0RlV281QXZpbkZBK0hqNGZwdFhKTjBpdnBUVFc3cXFKZ1NV?=
 =?utf-8?B?ZGJkTGJZcjJkY3F3NEY0WTVrUGdMTXNaR2lMSjJCSWR4YU42VUlBeDlsMXcy?=
 =?utf-8?B?aWRUL0NSTmpMQ0QwK2MrWTlRWWIvTnZ0M2VXR0Vtb1hHeHJFUnFFcEVtanAz?=
 =?utf-8?B?N1o3ZmNwdVc1b0tXbXBEVDhmWWlTWWxVeGpsaEt0MVRJUkVyL1ovRm5KbnJR?=
 =?utf-8?B?V3BVMEVSR3V5djA3cjZteXQwd2dFcGZocXhMb2w4TWtVVTA3cVdrT3FwRFZk?=
 =?utf-8?B?Y3FNZExQMjJtSk01QThXNmVINnhMN25INDZWODlEYlFodjlSY1FRbkxQdnRD?=
 =?utf-8?B?RUNVTlBUU2hWMURDRjZDZlhxdzgyRWJESU1LVi9ZNEdvUHAvOEN2Wk13OC9G?=
 =?utf-8?B?ekJTQlRrUFR3SlVYV3B6Qlp1TUpqanN5ZzBibVoyS2hYSXY4ZUhqb2RpWStT?=
 =?utf-8?B?emJzazQ3UFM2NDM3SmFpa01pZDZhSzI0YW1BTmVyb0dQcTZuNHRXVUl3bGxV?=
 =?utf-8?B?VG0ybk5STnZlblFuZExza3BFVkt6ZkI5eEM0d0xRPT0=?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba103daf-cd15-4f71-0e27-08db3fca85b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 05:05:26.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7odU8gaUqhVbLEQq6mXOTwvq+lhp8k10lO4lmDL07aTjYnZJ8VKDmCx3yGQcW/Hje0IziL3knPFtTovafnv+8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
X-Proofpoint-ORIG-GUID: pnrEe-FqBCwS81KehhCgVrbgMqDOmglj
X-Proofpoint-GUID: pnrEe-FqBCwS81KehhCgVrbgMqDOmglj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_02,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=909 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304180046
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNC8yMyAxMjo0MSwgRmFicmljZSBHYXNuaWVyIHdyb3RlOg0KPiBBZGQgZXJyb3IgaGFu
ZGxpbmcgaW4gX19kd2MyX2xvd2xldmVsX2h3X2VuYWJsZSgpIHRoYXQgbWF5IGxlYXZlIHRoZQ0K
PiBjbG9ja3MgYW5kIHJlZ3VsYXRvcnMgZW5hYmxlZCB1cG9uIGVycm9yLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRmFicmljZSBHYXNuaWVyIDxmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb20+DQoN
CkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlhbiA8aG1pbmFzQHN5bm9wc3lzLmNvbT4NCg0KPiAt
LS0NCj4gICBkcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMgfCAxOSArKysrKysrKysrKysrKysr
Ky0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jIGIvZHJpdmVy
cy91c2IvZHdjMi9wbGF0Zm9ybS5jDQo+IGluZGV4IGQxNTg5YmE3ZDMyMi4uYzQzMWNlNmMxMTlm
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4gKysrIGIvZHJp
dmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jDQo+IEBAIC0xMDQsNyArMTA0LDcgQEAgc3RhdGljIGlu
dCBfX2R3YzJfbG93bGV2ZWxfaHdfZW5hYmxlKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4g
ICAJaWYgKGhzb3RnLT5jbGspIHsNCj4gICAJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShoc290
Zy0+Y2xrKTsNCj4gICAJCWlmIChyZXQpDQo+IC0JCQlyZXR1cm4gcmV0Ow0KPiArCQkJZ290byBl
cnJfZGlzX3JlZzsNCj4gICAJfQ0KPiAgIA0KPiAgIAlpZiAoaHNvdGctPnVwaHkpIHsNCj4gQEAg
LTExMywxMCArMTEzLDI1IEBAIHN0YXRpYyBpbnQgX19kd2MyX2xvd2xldmVsX2h3X2VuYWJsZShz
dHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgCQlyZXQgPSBoc290Zy0+cGxhdC0+cGh5X2lu
aXQocGRldiwgaHNvdGctPnBsYXQtPnBoeV90eXBlKTsNCj4gICAJfSBlbHNlIHsNCj4gICAJCXJl
dCA9IHBoeV9pbml0KGhzb3RnLT5waHkpOw0KPiAtCQlpZiAocmV0ID09IDApDQo+ICsJCWlmIChy
ZXQgPT0gMCkgew0KPiAgIAkJCXJldCA9IHBoeV9wb3dlcl9vbihoc290Zy0+cGh5KTsNCj4gKwkJ
CWlmIChyZXQpDQo+ICsJCQkJcGh5X2V4aXQoaHNvdGctPnBoeSk7DQo+ICsJCX0NCj4gICAJfQ0K
PiAgIA0KPiArCWlmIChyZXQpDQo+ICsJCWdvdG8gZXJyX2Rpc19jbGs7DQo+ICsNCj4gKwlyZXR1
cm4gMDsNCj4gKw0KPiArZXJyX2Rpc19jbGs6DQo+ICsJaWYgKGhzb3RnLT5jbGspDQo+ICsJCWNs
a19kaXNhYmxlX3VucHJlcGFyZShoc290Zy0+Y2xrKTsNCj4gKw0KPiArZXJyX2Rpc19yZWc6DQo+
ICsJcmVndWxhdG9yX2J1bGtfZGlzYWJsZShBUlJBWV9TSVpFKGhzb3RnLT5zdXBwbGllcyksIGhz
b3RnLT5zdXBwbGllcyk7DQo+ICsNCj4gICAJcmV0dXJuIHJldDsNCj4gICB9DQo+ICAg
