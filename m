Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FCA60D72B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiJYWcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiJYWcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:32:48 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BAB2E68A;
        Tue, 25 Oct 2022 15:32:47 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PJrC2h023480;
        Tue, 25 Oct 2022 15:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=XiqySxuR+N/9fsejVbv1eXj04SGs5IhNMd3Yz/XFqHA=;
 b=nSJTJsMspN+bWtMJQKw9Jz5Wr2XqDYEBRhkQZAG1xwF/3KV1tZ2piop/PFnRkM2DaNNL
 LR4WBCHnSULlYR5C0SMqoBIjmrmrbOyff/Id0O05t8pUnOxiNwwXIIFwbcJ0xPmHCZXD
 Vw8vGCofXBoWy6LMrFxLk6a8kjrRhgC71qPZ/Xm8NznCkRfR441pIeKBs6CMLZwOOPh+
 8veEDReIrECKba2q+FEof7E6fYzU6BZ7PM/sAobHp7QnbZtw/sCGAJ8uCF7h68VOoOyf
 kM8yH8dzyC+M9kpj6pa7lSEO8te0o8XymZCGwrfMmSeZyEK4QllkyrKjWiVaxHyGunl0 Gw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3kcfs7hmgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 15:32:28 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 831E3C00F4;
        Tue, 25 Oct 2022 22:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1666737148; bh=XiqySxuR+N/9fsejVbv1eXj04SGs5IhNMd3Yz/XFqHA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=isSK7mzzom9Ug2gwmAXPmqAfXE6FCkv8ziAOJw68OQycBxiE9fvqKa4kgKtZLDFv1
         djt6Z9vRecUKV4hqRM71LHHAcBUL7lvXWEsBdeQFJueN6zvOpCZ2J7WrNaMRoSDnE+
         /aN9prl5PbLrkILg3YIjoa8gwrsIbTqIAwMI49u7IKwXQ/c5arTuTG1073mepUZd5l
         9DkHLgAGF5I8xfcD8rVPwt6/aF7998Ye4rMSFqH4BytdJHb+qvLcG/uIdNWMbHG2dZ
         GbSlV3XCVrZrEWxcPFHrpi0QkjQmiquApVKdWu5msYQt7s3myxo3y/PSJteVVvSd8A
         AQ4lVrub7JZBQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7096AA0073;
        Tue, 25 Oct 2022 22:32:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 08AD0A01CB;
        Tue, 25 Oct 2022 22:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E63knoihXWamrSHn+S7V+6Ia5I303JPcN0DmpthT+95YYWKbHBjVvuiAIGhoW6F/z4V5QTFsTu2tFvV5mTRmq9uli+VaKt66fhxADd3JEADjNb8umsH4QR4AGzVmN3993VSAzFQWueBlIARF79xB5JtqcQPE/zMqazDwCYyyO/vZHeQy+sAZYl9d7Von3g/iA/ZojSjlwCpuWFzAw0DbvnCKoJY0YDkbGT0S07ZJu8b4eCMR1jwYHvMNf2NFBOQzSmGYpprdYMFRu1f5T4h0fn3qXx9RvRrGCZvanheILcXXuiUoadLuXmus4K8PW+/IqtsegdSG8M9eTpGsEnXL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiqySxuR+N/9fsejVbv1eXj04SGs5IhNMd3Yz/XFqHA=;
 b=cB9/qQJZXJQnCQjw4o7zOhu5Cqxn0Bp4dC9gYpm/zOlw+cMLrYQ8CHQn/LeYBWc8LDkYFjh5mEDDaFkp8xKt+9ZfrwaotFckuyZxC5RwOazHpsfLMVJcAQBEsFMn0IJl9RPF/LM6rmniwq0Z80+lJP/evL9+ZbtsBqAEKSrcHuPhwEVrd986Z+SfACZesjoYZ2h9IiPq2SaNr6zgtJL8ZIbmg7WaIpAc0tQ7wcNjkgypF2DgR5E6XH0BqxKdmZBQn25QIWfAaTX1nT3+eDX9cgEopMh32KvVgJRApBpqcmBPU7lEY+5/dNK7FQu3+48vJ2kb2zaZsilsE4dbqncEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiqySxuR+N/9fsejVbv1eXj04SGs5IhNMd3Yz/XFqHA=;
 b=izWARutBE7h6KoxiuSjypmga+Fyj/BNcoNSvtwoERXb/feiuROjVddbYt3hhI4SLlOQVwJDfSg9oMtEMzf1rVRGVAIGSHuktf9AkLgruLnBm+nkJ7CLehpCh7ncJoUlppQNHqw/gwPIAy1om72gcGbLiK/83k49MrB9y217pEx8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 22:32:21 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::525b:92b6:eafc:8629]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::525b:92b6:eafc:8629%7]) with mapi id 15.20.5676.031; Tue, 25 Oct 2022
 22:32:20 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jeff Vanhoof <jdv1029@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: uvc gadget performance issues with skip interrupt impl
Thread-Topic: uvc gadget performance issues with skip interrupt impl
Thread-Index: AQHY6DvJDsQtZ4K4e06Dek7nfdl1M64fssMA
Date:   Tue, 25 Oct 2022 22:32:20 +0000
Message-ID: <20221025223208.5qjehgot5ri4ygx6@synopsys.com>
References: <20221025063359.GA19049@qjv001-XeonWs>
In-Reply-To: <20221025063359.GA19049@qjv001-XeonWs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN0PR12MB6296:EE_
x-ms-office365-filtering-correlation-id: 5e47e211-f583-48b2-b808-08dab6d8c7a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ces0mL3qFcWY8I6kdGZb1L3O+/BNwHf2R0v78M2caRwk8ynzz5ynn8hOV2VWs5sDgth7D0xhC6SLJAJaPQbl+WNmpzul6JDgXU0H7uX2AEJv0vmGqfDLf9ekbcgIFVB2qNxXnfHl/7qg3Zu43SdUXNQkJafhpRu4Uv+JFwFdAPXlvl+Zx2oZaGo/j6GX+Ia2PW2q3E+LidFo8txqFcCzxV6F1OGZOUvOUHSATApEqBbJqzA+9cRrkwihSdkVCnzUSg6yWuVvjQhc3wPo6ohWa6AzY/HP8CRkOpjUWbmlbF1d94LfOFKRvmWqZjQOg9SxzkU0qL7p53DTRt0LqURzA7cP9WMSia+zNzjPiLiccQugJsvtkIp+nAPfjev7+ttWH+l2UcpX0oEsDXg49SOMov1gfcDd1XT5KKiYoahuHRo424UAkEolI9uO8VJEeoN5g0jj4tU2gS4KxujSkCmKQQiNkBrLfF1DkwRGNTcFRVZBLui9wk3QqTozapinB37LMdpDtJgHSX2EDc5Ssr0ohpdzk2ecsI3ve8VKTl4XcEkdlGgTcahO/o1B0jTQbVkl+heQ4d7Ls9FEn7r0fSBfyecs6FjipVitnaek63Db2j3NV7+VXYZwl+QmQtg57eFGwB5m7nk+Q2NPJYO/PZIYJlJPAHozFdpgU9btPax64VWKHEFQfvu4ApcLGuNwwpLibd2DPk/Itthi8qQ6Svm2LQrA2glC7WQZbGmgsr41X+mUj1Ol+53O2jJLitwtVHqRJHA03PCNeY9mwcOdUOcytcXRHmwhvQDNWqGVDiPP4QU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(478600001)(966005)(71200400001)(6506007)(6512007)(26005)(6486002)(8676002)(66556008)(38070700005)(76116006)(4326008)(38100700002)(66446008)(64756008)(5660300002)(41300700001)(66476007)(66946007)(7416002)(8936002)(122000001)(2616005)(83380400001)(186003)(36756003)(1076003)(54906003)(86362001)(316002)(2906002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXY0cU44Uld6Z0NGS0daK0plcjM3SjBiQzYvWDlQc2dDT2JLUmkzK0cycWU0?=
 =?utf-8?B?djYyaTBNQXJJeDZMRmZweEEzbFVBeTJwbzJYcGZXc2hzU2N2NkJkNEhDc0hC?=
 =?utf-8?B?TjRIczJQUzNKZDZCeWRWL2NraHpmWWJNdEJBdWhMaDh5d1hlYnBBSVJLTk14?=
 =?utf-8?B?Yk5VNVRUSksrWHRSZUNZTW9uUS9LQW5KWHQ5TlZEME1qUDdRL1grVHZ4VFhp?=
 =?utf-8?B?aXdMSE5kcytxVDlsSERxWWl1Wjh4RmxTZnF6VCtQRnBUc20rRnBUdmVsbll1?=
 =?utf-8?B?OGtMSVZsK1ZvZ0p3MGZyVUIxdGZSclUxMHhkNkQzUnFKN3FLcmtRYzFjT21R?=
 =?utf-8?B?Q3ZzS0JTakN0aHNSN2theEZJM0hVVnlhaGdMS2xYbEhoeDZVQ0p3TXhXbmRR?=
 =?utf-8?B?dUZkZ3E5L0FaTEIybzVSeFpRR1FmM1hTRTFSUWFTRjl0Q3pLUlBJd1ZDdmdV?=
 =?utf-8?B?NjQvYmg3TDBPTWd3T3ZOMUZtRElkTEE0Vm01VFVKSnp1dVZ4OVNEQ0x6QW1o?=
 =?utf-8?B?Y2N3YmxCM2NBSHMxa0xDM255NUo1K3QwbGQ3ZkpBVnZsVEJBM0Z0am1zMzNH?=
 =?utf-8?B?a21BQ1BrOW96eDJFQUxWdXMyYmpkY2I2c1h2ODErOXdST2FRbFBNVWNPTnFN?=
 =?utf-8?B?cEJGRFRoK203MEI3cXQxZWozbHJGRmsweStvQ05VczVRKzByVHRQYlhrKzlG?=
 =?utf-8?B?K3FlY2F2N01XQ0xVeitCYjkzaEE1RGQ1ajA2bWE2MHhHbDFzQWNCYzN3c2No?=
 =?utf-8?B?VnBZajUwRzloRXRweGNaUXZDK1dCMXIrbHRHNDd4a0ZnMEZ2ZTVzMUlZc2hZ?=
 =?utf-8?B?VVRrSWo0SmUzdVJkUlI1MFk2U05vZDNZZ25qV2oyMTJLc2tlUk4vcEdLckpX?=
 =?utf-8?B?RHVrRzZRNXJ4NmFIeTk1SVkvbnBOQ0ZkYjFjQTVlOElUWHA3dFBWWW05WGp4?=
 =?utf-8?B?TnpZVXdZSXBXTFlaYVVtVDBwUW9Gc3RSWWF1K0hMRnNjRUNtQ2tiVlVRUUF3?=
 =?utf-8?B?NWF4Umt5SitzUlVUck9ubDZTYmM0VzdIWE1YZXJOeDl3bVd2ZVRrNmgwTzh6?=
 =?utf-8?B?RERZdFdvd0RvNXM3eU5EM2Zad0M3MlVoZ0dxYzJwZ2Jsc0N6Q2RGZ3QyWkxs?=
 =?utf-8?B?ZCtQaUQvQnN5bHBHS0dNVFl0SzJjRll4SFNHRXdQcldwc0pDNmVMS1dXTjFU?=
 =?utf-8?B?dUhxczh2MzFMTkNFVnlBZGlHc3h1aEtqVytuYkJha254bFYvOElRWlBTRW5Q?=
 =?utf-8?B?QkJvMmtFQWc2Yk5zcVNjUmdYS2R5cHRHemVHZGdhQnk0S1dneVNqRkhqTFBm?=
 =?utf-8?B?ZDdONmVhd05mazJ0ZEZiUzRSL2VXRm9PWW1xUXBtRUJNYmZnZk5LK1R3dXQ3?=
 =?utf-8?B?Z3lWSXF5Q2V4Q0EwY1BRcU5SYmNaWEwwWndqK2VWRzBzL3lPVkxiV3ZpdUlF?=
 =?utf-8?B?bFZrMDhROVc5VjY3dEtWRjJJdVlIcGx5azZRWWpUVW1pd1Q4NlhYaDJPdlZJ?=
 =?utf-8?B?L2dKaS9HdFVmRmJwRFdvRTA0NGhGc3dnR1Q3VHFUb2xnTHl4dnRYOXErblB6?=
 =?utf-8?B?MlZSY3JDRHdsRFlCMUNvaE5sc1pSK08reCsxbmhQOFJSa0RjbWlvWlZFdXJY?=
 =?utf-8?B?T0t0OHV4a3ZDdUFLL08rSjE3Uldzb1V4YjNtZ3c4WGxWcS9NbHJBMDQ2azNF?=
 =?utf-8?B?TVhOenYvdk0wdjFXRWVEZ2RPUUlFamJZd2crcHFSY2VIb2dqSEtQTjhCSFEw?=
 =?utf-8?B?bXhiV005ZytwS0xBZTVBZWlPL0xyS0hQYVpxZzc0emVacHNjYjlVdlN2citW?=
 =?utf-8?B?ZGxHTW5WOUh3emNUL0ZYelQvTUZKZWNtdHJ5UkdLUXZPNW9HdUZFZ2h2NXNz?=
 =?utf-8?B?MldaN21CMGllVy9YUURPNUpiOGlPRjVoaDZuMXd6cG5kRGVyTE9xWmFhSzA4?=
 =?utf-8?B?eWJiL1RyT1JZdm9qNVRZTjd0OE52MXZzSjlnZHNQMGt1V1JZNVdZYzc4czJ3?=
 =?utf-8?B?WU5odENYZEdQNy9rZXRPeWtVSDFqcmhEM2Q2bDdlQ21VRUtEYTdCUmUyejZl?=
 =?utf-8?B?ZCtiang5LzM2K3lOaFdVeGZhMVN2eFpmUFNoT09ad3FTQzF1eDJ0Q1RLY2lD?=
 =?utf-8?Q?U74PN7X2PsTfA+AwpjSZxA3qT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D335D65009FE84F8ED8CADA891E0E53@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e47e211-f583-48b2-b808-08dab6d8c7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 22:32:20.4882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkTMRIDqMUw/UVcbrRhr85I63S3iVvNj6WAETIhbSoKADR36v0npgLXMnCRegRG9p0wFptFgfBtj9kt6ssTpgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
X-Proofpoint-GUID: K0Pct0Kv9qBRr7eo_7v4HXn2-DQbsqXt
X-Proofpoint-ORIG-GUID: K0Pct0Kv9qBRr7eo_7v4HXn2-DQbsqXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_13,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 mlxlogscore=651 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210250125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBPY3QgMjUsIDIwMjIsIEplZmYgVmFuaG9vZiB3cm90ZToNCj4gSGksDQo+IA0KPiBE
dXJpbmcgdGhlIHF1ZXVpbmcgdXAgb2YgcmVxdWVzdHMgZnJvbSB0aGUgVVZDIEdhZGdldCBEcml2
ZXIgdG8gRFdDMyBmb3Igb25lDQo+IGZyYW1lLCBpZiBhIG1pc3NlZCBpc29jIGV2ZW50IG9jY3Vy
cyB0aGVuIGl0IGlzIHBvc3NpYmxlIGZvciB0aGUgbmV4dA0KPiBjb25zZWN1dGl2ZSBmcmFtZShz
KSB0byBhbHNvIHNlZSBtaXNzZWQgaXNvYyByZWxhdGVkIGVycm9ycyBhcyBhIHJlc3VsdCwNCj4g
cHJlc2VudGluZyB0byB0aGUgdXNlciBhcyBhIGxhcmdlIHZpZGVvIHN0YWxsLg0KPiANCj4gVGhp
cyBpc3N1ZSBhcHBlYXJzIHRvIGhhdmUgY29tZSBpbiB3aXRoIHRoZSBza2lwIGludGVycnVwdCBp
bXBsZW1lbnRhdGlvbiBpbg0KPiB0aGUgVVZDIEdhZGdldCBEcml2ZXI6DQo+IA0KPiB1c2I6IGdh
ZGdldDogdXZjOiBkZWNyZWFzZSB0aGUgaW50ZXJydXB0IGxvYWQgdG8gYSBxdWFydGVyDQo+IGh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEw
NjI4MTU1MzExLjE2NzYyLTYtbS5ncnplc2NoaWtAcGVuZ3V0cm9uaXguZGVfXzshIUE0RjJSOUdf
cGchWWlmY0daWjlmYUVNVHZCX1NyRUxTUzFpTnc1MGtvU2lhZzN0T05Lay0zVG94ZlBMNUxpMEtU
czZLVXViX3NVbDNNOVZnS2Q5cUM4UHNOZ3VWX2w2JCAgDQo+IA0KPiBCZWxvdyBpcyBhbiBleGFt
cGxlIGZsb3cgb2YgaG93IHRoZSBpc3N1ZSBjYW4gb2NjdXIgKGFuZCB3aHkpLg0KPiANCj4gRm9y
IGV4YW1wbGUgKElTT0MgdXNlIGNhc2UpOg0KPiAxKSBEV0MzIGRyaXZlciBoYXMgNCByZXF1ZXN0
cyBxdWV1ZWQgdXAgZnJvbSB0aGUgVVZDIEdhZGdldCBEcml2ZXIuDQo+IA0KPiAyKSBGaXJzdCBy
ZXF1ZXN0IGhhcyBJT0MgYml0IHNldCBkdWUgdG8gbm9faW50ZXJydXB0PTAgYWxzbyBiZWluZyBz
ZXQsIGFuZCBJTUkNCj4gYml0IGlzIHNldCB0byBkZXRlY3QgbWlzc2VkIElTT0MuDQo+IA0KPiAz
KSBSZXF1ZXN0cyAyLDMsNCBkbyBub3QgaGF2ZSBJT0MgYml0IHNldCBkdWUgdG8gbm9faW50ZXJy
dXB0PTEgYmVpbmcgc2V0IGZvcg0KPiB0aGVtLiAoTm90ZTogV2hldGhlciBvciBub3QgdGhlIElN
SSBiaXQgaXMgc2V0IGZvciB0aGVzZSByZXF1ZXN0cyBkb2VzIG5vdA0KPiBtYXR0ZXIsIGlzc3Vl
IGNhbiBzdGlsbCBjcm9wIHVwIGFzIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGF0IHJlcXVlc3Qg
MiwzLDQNCj4gd2lsbCBzZWUgYSBtaXNzZWQgaXNvYyBldmVudCkNCj4gDQo+IDQpIEZpcnN0IHJl
cXVlc3QgZ2V0cyBhIG1pc3NlZCBpc29jIGV2ZW50IGFuZCBEV0MzIHJldHVybnMgdGhlIHJlcSBh
bmQgZXJyb3IgdG8NCj4gVVZDIEdhZGdldCBEcml2ZXIuDQo+IA0KPiA1KSBVVkMgR2FkZ2V0IERy
aXZlciwgaW4gdXZjX3ZpZGVvX2NvbXBsZXRlLCBwcm9jZWVkcyB0byBjYW5jZWwgdGhlIHF1ZXVl
IGJ5DQo+IGNhbGxpbmcgdXZjZ19xdWV1ZV9jYW5jZWwuDQo+IA0KPiA2KSBVVkMgR2FkZ2V0IERy
aXZlciBzdG9wcyBzZW5kaW5nIGFkZGl0aW9uYWwgcmVxdWVzdHMgZm9yIHRoZSBjdXJyZW50IGZy
YW1lLg0KPiANCj4gNykgRFdDMyB3aWxsIHN0aWxsIGhhdmUgcmVxdWVzdHMgMiwzLDQgcXVldWVk
IHVwIGFuZCBzaXR0aW5nIGluIGl0cw0KPiBzdGFydGVkX2xpc3QgYXMgdGhlc2UgcmVxdWVzdHMg
YXJlIG5vdCBnaXZlbiBiYWNrIHRvIHRoZSBVVkMgZ2FkZ2V0IGRyaXZlcg0KPiBiZWNhdXNlIHRo
ZXkgZWFjaCBoYXZlIG5vX2ludGVycnVwdD0xIHNldCwgYW5kIHRoZSBEV0MzIGRyaXZlciB3aWxs
IG5vdCBoYXZlDQo+IGFueSBhZGRpdGlvbmFsIGludGVycnVwdHMgdHJpZ2dlcmVkIGZvciB0aGVt
IGFzIGEgcmVzdWx0Lg0KPiANCj4gOCkgQXBwcm94aW1hdGVseSAzMC0xMDBtcyBsYXRlciBhIG5l
dyBmcmFtZSBlbnRlcnMgdGhlIFVWQyBHYWRnZXQgRHJpdmVyIChmcm9tDQo+IFY0TDIpLCBhbmQg
aXQgcHJvY2VlZHMgdG8gc2VuZCBhZGRpdGlvbmFsIHJlcXVlc3RzIHRvIHRoZSBEV0MzIGRyaXZl
ci4NCj4gDQo+IDkpIEJlY2F1c2UgcmVxdWVzdHMgMiwzLDQgYXJlIHN0aWxsIHNpdHRpbmcgaW4g
dGhlIHN0YXJ0ZWRfbGlzdCBvZiB0aGUgZHdjMw0KPiBkcml2ZXIsIHRoZSBkcml2ZXIgZG9lcyBu
b3Qgc3RvcCBhbmQgcmVzdGFydCB0aGUgdHJhbnNtaXNzaW9uIHRoYXQgbm9ybWFsbHkNCj4gaGVs
cHMgaXQgcmVjb3ZlciBmcm9tIHRoZSBtaXNzZWQgaXNvYyBzaXR1YXRpb24gKHRoaXMgdXN1YWxs
eSBoYXBwZW5zIGluDQo+IGJldHdlZW4gZnJhbWVzKS4NCj4gDQo+IDEwKSBTb21lIG9mIHRoZSBy
ZXF1ZXN0cyBmcm9tIHRoZSBuZXcgZnJhbWUgd2lsbCBoYXZlIG5vX2ludGVycnVwdD0wIHNldCwg
YnV0DQo+IHRoZXNlIHJlcXVlc3RzIHdpbGwgYmUgY29uc2lkZXJlZCBtaXNzZWQvbGF0ZSBieSB0
aGUgRFdDMyBjb250cm9sbGVyLg0KPiANCj4gMTEpIEJlY2F1c2UgdGhlc2UgbmV3IHJlcXVlc3Rz
IGhhdmUgdGhlIElPQyBiaXQgc2V0IChhbmQgcG9zc2libHkgSU1JKSwNCj4gaW50ZXJydXB0cyB3
aWxsIGJlIHRyaWdnZXJlZCBjYXVzaW5nIHRoZSBEV0MzIERyaXZlciB0byByZXR1cm4gdGhlIHJl
cSBhbmQNCj4gZXJyb3IgdG8gdGhlIFVWQyBHYWRnZXQgRHJpdmVyLg0KPiANCj4gMTIpIEFuZCBp
ZiB0aGUgbGFzdCBzZXQgb2YgcmVxdWVzdHMgc2VudCBieSB0aGUgVVZDIEdhZGdldCBEcml2ZXIg
aGF2ZQ0KPiAibm9faW50ZXJydXB0PTEiIHNldCwgdGhlbiBEV0MzIG1heSBub3QgaW50ZXJydXB0
IGZ1cnRoZXIgdW50aWwgbmV3IHJlcXVlc3RzDQo+IGNvbWUgaW4sIGFuZCB0aGUgY3ljbGUgb2Yg
ZnJhbWUgZHJvcHMvZXJyb3JzIHdpbGwgY29udGludWUuDQo+IA0KPiBJIGhhdmUgYnJpZWZseSBt
ZW50aW9uZWQgdGhpcyBpc3N1ZSBpbiBhbm90aGVyIGNvbnZlcnNhdGlvbiB3aXRoIFRoaW5oLiBB
dCB0aGUNCj4gdGltZSBoZSBtZW50aW9uZWQgdGhhdCAzIHRoaW5ncyBjb3VsZCBwb3NzaWJseSBi
ZSBkb25lIHRvIGhlbHAgcmVzb2x2ZSB0aGlzDQo+IGlzc3VlOg0KPiANCj4gMSkgVGhlIFVWQyBH
YWRnZXQgRHJpdmVyIHNob3VsZCBlbnN1cmUgdGhhdCB0aGUgbGFzdCByZXF1ZXN0cyBxdWV1ZWQg
dG8gRFdDMw0KPiBtdXN0IGFsd2F5cyBoYXZlICJub19pbnRlcnJ1cHQ9MCIgc2V0Lg0KPiANCj4g
MikgRFdDMyBjYW4gZGV0ZWN0IHN0YWxlIHJlcXVlc3RzLCBzdG9wIHRoZSB0cmFuc21pc3Npb24g
YW5kIGdpdmUgYmFjayB0aGUNCj4gcmVxdWVzdHMgdG8gdGhlIFVWQyBHYWRnZXQgRHJpdmVyLCBh
bmQgcmVzdGFydCB0aGUgdHJhbnNtaXNzaW9uIGZvciB0aGUgbmV3IHNldA0KPiBvZiByZXF1ZXN0
cy4NCj4gDQo+IDMpIFNldCAibm9faW50ZXJydXB0PTAiIGZvciBlYWNoIHJlcXVlc3QuDQo+ICAN
Cj4gSSBoYXZlIHRlc3RlZCBvdXQgdmFyaW91cyBpbXBsZW1lbnRhdGlvbnMgZm9yIGFsbCAzIHBv
c3NpYmlsaXRpZXMgYW5kIHRoZXkgZWFjaA0KPiBzZWVtIHRvIHdvcmsgb2suIE5vdGUgdGhhdCB0
aGVzZSB0ZXN0IGltcGxlbWVudGF0aW9ucyBhcmUgbm90IHJlYWR5IGZvciBwcmltZQ0KPiB0aW1l
LCBidXQgc2VydmVkIGFzIGEgd2F5IHRvIHByb3ZlIHRoYXQgcG90ZW50aWFsIGNoYW5nZXMgaW4g
dGhlc2UgYXJlYXMgY291bGQNCj4gaGVscCB0byByZXNvbHZlIHRoaXMgaXNzdWUuDQo+IA0KPiBJ
IGJlbGlldmUgdGhhdCBhIGNoYW5nZSBmb3IgdGhlIFVWQyBHYWRnZXQgRHJpdmVyIHNob3VsZCBi
ZSBtYWRlLCBidXQgaXQgYWxzbw0KPiBtYWtlcyBzZW5zZSBmb3IgdGhlIERXQzMgZHJpdmVyIHRv
IGFsc28gYXR0ZW1wdCB0byByZWNvdmVyIGZyb20gdGhpcyBzaXR1YXRpb24NCj4gaWYgcG9zc2li
bGUuDQo+IA0KPiBEb2VzIGFueW9uZSBoYXZlIGFuIG9waW5pb24gb24gdGhlIGJlc3Qgd2F5IHRv
IHByb2NlZWQ/DQo+IA0KDQoNCkp1c3QgY3VyaW91cywgZG9lcyB0aGUgVVZDIHByb3RvY29sIGhh
dmUgc29tZSBzeW5jaHJvbml6YXRpb24gbWVjaGFuaXNtDQppZiB0aGUgdmlkZW8gZGF0YSBpcyBj
b21pbmcgaW4gbGF0ZT8NCg0KSXNvYyBkYXRhIGlzIHRpbWUgc2Vuc2l0aXZlLCBhbmQgaXNvYyBy
ZXF1ZXN0IGlzIGVhcm1hcmtlZCBmb3IgYQ0Kc3BlY2lmaWMgaW50ZXJ2YWwuIEFzIHlvdSBtZW50
aW9uZWQsIGEgY2hhbmdlIGluIFVWQyBnYWRnZXQgZHJpdmVyDQpzaG91bGQgYmUgbWFkZS4gSWYg
d2Ugc2ltcGx5IHdvcmthcm91bmQgdGhlIHVuZGVycnVuIGlzc3VlIGJ5DQppbXBsZW1lbnRpbmcg
aW4gb3B0aW9uIDIpLCB3aWxsIHdlIGV4cGVyaWVuY2UgZHJpZnRzIGluIHRoZSB2aWRlbyBkYXRh
Pw0KKGUuZy4gdGhlIHZpZGVvIG1heSBub3QgaW4tc3luYyB3aXRoIHRoZSBhdWRpbykNCg0KRG9l
cyB0aGUgVVZDIHByb3RvY29sIGFsbG93IHVzaW5nIGxhcmdlciBwZXJpb2RpYyBpbnRlcnZhbD8N
Cg0KVGhhbmtzLA0KVGhpbmg=
