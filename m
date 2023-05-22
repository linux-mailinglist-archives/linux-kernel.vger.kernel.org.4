Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A891070CC1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjEVVRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjEVVRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:17:12 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6513F9C;
        Mon, 22 May 2023 14:17:11 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKnU4G011538;
        Mon, 22 May 2023 14:17:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=1c5hNf2pQjJ4dEesEgCWPo/yHWp23v2j8P/PCxOipAE=;
 b=N8HPDSaeikIKlns7YRWnBqT0tcGBcr09lbqyt5FJEfxwzKfYH4auwDUFXThC2TkxNQ+s
 xPSQkSzmMGkNJEvZGk5NrNZeogTpB5kQfPZ5UOnlCJTl1VIcvSqvge9xQQBuaBEP7DxR
 3i6CzaOlLxPb7uerls2zPlHmFWLHQXVRkcS+QggijecRu1BqBBVnh6U9ycL0/lsh34Uh
 tv99uuFhyg0KvFHs2/gG3bnJT383deCMCUnedkwJI8rmmVpbdieqmaY0ZXgqHTMIN425
 QF1xjZKHfNkb6hQ0Wqzdhdd2lyqby7u0o51KJytNNyeykwTAlL3iAHMs5Mlc0H5+SJ8K eg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3qpwf4r9cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 14:17:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1684790227; bh=1c5hNf2pQjJ4dEesEgCWPo/yHWp23v2j8P/PCxOipAE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Ms264Qhc2XRAU/4HKnCkoVD4YdtLZjceZcKuRweVYfL43SZDEH1ffu92SJBsPoftU
         e3RU0QCRNT0jyhVNC9jTHI8EiWqgjOb7lvjvfzrhgwW+6uX4dp+AXGDkcL9HV1pPFH
         TcH/bsV4l/JhYNH6/ES3ybAImFcHOobHHVT+83qC9CztoLEqPXAJ7gzEgCgDPCY9SR
         NVWX8+EdrTxcVhVrJuIJmtmLTgxodQOyR3wLTDKzW6XdLBAdYISFw7NmFlUymY2NDO
         tWjd851OCzsWxR2tX8FDcl5gc46uWZcLQEzxkI4wl0Jaqc378x/X4S9+9FDtvmfb22
         qINGT0mRSlREQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D6A8540407;
        Mon, 22 May 2023 21:17:06 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 146BDA0079;
        Mon, 22 May 2023 21:17:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=PUEqn5E2;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 38C5A40637;
        Mon, 22 May 2023 21:17:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5vordttZXtn+Y4MfkyjgXUtV5nahl9zX/SO1KOY+x+QgBYGoOCzNYdZVkcmj3v33xNmf1F6cXFMwwEGXL7g575edvd5PSqJ+P6SuP74DjZCEYjYda1LatPIbp4GsFpvRi7gvm+L/y5DHmzkdnFqLUcyFvkmSjbnRhvlj/0y+/ekwyJU9VYORXsVEJRlR3PD0UCNl2B3U/xiEAtmWg2p2RsK2Nh2O8M6kqz2A467xlUpAssPOMoAipuNITN9/vpi4ZlPrBKCGSE5J439gy3bdODWu+Qcc6NMGzIB3V42z+H+cGnyP80MPpOyqGBwVZTfcuWSMeoBu4OvE28PtGLCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c5hNf2pQjJ4dEesEgCWPo/yHWp23v2j8P/PCxOipAE=;
 b=ZpVgtNMCcKPMaWP5fHaio0QZlFXzBR2yXHH9U0FeQW6OFk17v3zW7dDEwGPzxH5sDb+2wH0ZKlhTi4gbDfq8wUklW7HtzH0BjuUqBVuhUpy4P0NuX77PLxpNRWxQtWEtOmNw2UxyUYsi/Xynp6oLL3ceV1teQGZvDZ2D3NXQoTcepUQhCu0cIHnuPbDDkHXio0XqOZAcHjAxvkxcSUyJgCD/O9oMjeatHJJzj3/x0eG0ZKRfGROtgY9ugKB4YqPURtTTWsGMOfewdEortKuu2SHEQZBA+CXJDynNn2BCiponXHISogjLUP0PmahT1EIuyilfBCkA90dr2YIAVZNjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c5hNf2pQjJ4dEesEgCWPo/yHWp23v2j8P/PCxOipAE=;
 b=PUEqn5E2PIMJuw9Zp9rDmwffqrDAl0CJ9Hvgohr8yanmjGLgVidCxOnik/M//l46z4KaE3eJ0SFkhveP8ETuKnC6n6vyeRIhhOUWKx1p10gjO5b2sRTkRMEBxjUmrtRlV1z22FS96Jk2xWjLmOhfE0GNDobCRsJM5xmhXZAdsaY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 21:17:02 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%6]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 21:17:02 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [RFC] usb: dwc3: gadget: Fix amount of data copied from event buf
 to cache
Thread-Topic: [RFC] usb: dwc3: gadget: Fix amount of data copied from event
 buf to cache
Thread-Index: AQHZi8uJ8yaHXEonWUKmsB+vQuMnU69mzdyA
Date:   Mon, 22 May 2023 21:17:01 +0000
Message-ID: <20230522211651.rr2r3caz6ni7m6xr@synopsys.com>
References: <20230521100330.22478-1-quic_kriskura@quicinc.com>
In-Reply-To: <20230521100330.22478-1-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW4PR12MB7360:EE_
x-ms-office365-filtering-correlation-id: 50f6ed26-3e00-419e-93e2-08db5b09e2d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sPQH22N6NQ9aaZiNAmtnt3k7xLsa1FQKCRAuMomsgTB+kSmuebtZkIU1/Rck2l7Iy3NKOMQG9P8dxJsgcievbIvG2TTUarZ8WBzoruhITS1BVQbiDB5J31oy5FEqgFM9B4/ZfXkzSCyKFGhj53x1m3ewqQg+jx7ATSn4MA10OTHrfJBrAahWTwUXzTdWNP5aHEkNMpcwUvUd4VDfAJO50cLw2cVOtAA85KykGivLWVmHDChxYOt8yqm3u/lsw1BXK02rgBvhSEfaGKnuyYBIY23d1AOOp7Qbt39gsU0O8QQ/08ftfQXcaoo+PtwORPYFJQuHIoZ2kMv2cLj6L4nwiUnm9wyAc8XBEBLuHhGoN4MiT+ZhcRq60R//rt/Wcg7QcxMc1CinYLyxrWffWcMHDiFNiFcSaVWrAZ8Sm1Zggp+zAV0qKsI1qAvMoHCj1lDYbu29gvM1f+v4e05EbWy2R7kMW34Qo+d6ff9B6IuKFtamZ8lMhWl8a5lBTJ+19IJSly4U4igIhnNfpNR4bZNa/kfREl9+6PjaZEn1VLGLjyrq5CJ8N8n6WHtKofqcC6+63rg/EbZAcyMNvDj0cL8t/0MpakuDYQg/SUEdry6VMFLUND2+0eBqEMnPfAS4F6CLdKfq4NQ4Ix/9dNvFB++2lIDmDNadCYyqO3arIowE7+k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(186003)(316002)(86362001)(26005)(6506007)(1076003)(6512007)(71200400001)(2906002)(8936002)(8676002)(36756003)(5660300002)(41300700001)(6486002)(478600001)(54906003)(38100700002)(122000001)(2616005)(66476007)(66556008)(66446008)(76116006)(64756008)(4326008)(6916009)(66946007)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmZydURRZ0xsOUZFYUcrN21ybzZ2Ky9aVW1kYWhTbXdUZjV4ZnBMSzNKT0RS?=
 =?utf-8?B?djFROE8wa2Nuejl1VkZQRmM5ME53SlJQSVZTSmZGOXkvcy9wOWJUM0RVTnBL?=
 =?utf-8?B?eGVzUHY4UjN6akJlVkRmZ25TL2dXWlM1T3pGV1dTTlZjZmpGV3ZUaTNkYmVU?=
 =?utf-8?B?cXN0aUNjQ09Qd2tBQU0zalJ4R1ZtclBXME1tbTQ1U1M4ZmI5bTJuUEJ2ZjF5?=
 =?utf-8?B?eG85anI0NHNFWTlzRUt2NmlhZittcHVSeUlTM0EvMnZnd3ZnZ0VjdFhLa3Vw?=
 =?utf-8?B?VDVmUFZxd1BsQnI0cWJIckpEVTlNbk96WkpZc0hTN2lmMWt0ZnpVSlhmVmpr?=
 =?utf-8?B?SHMzNzBMVlNYd2pIUmdkZWpraEZDSjRYTWFvNGdlcWwraVlTODFlWUJNV3ds?=
 =?utf-8?B?SlZkbm0wR2cwMDRPVmV4WnExRmFvSks3Y2llSEtDZWtDR0R6M0x4clZRQlo3?=
 =?utf-8?B?V1FjV1M3eG0vcXcvM2gwRXhYTHBDcjI1dzI3KzN1bmRuVi9XZ2pEQ3ZqTmQ4?=
 =?utf-8?B?SExuRWNIcVpxamxvVmtMQTBzNTZKdDhYM250NGw4Q2VpSWx4b05zREg4eGE4?=
 =?utf-8?B?RDJwRy9xQWl3L3E3MlF2Zk1HMXpNaXM3R3QzbmZHQ3NqOTUvblhDNFE4eHNO?=
 =?utf-8?B?Nm1idEVOZ2xCNWxzSFNWTGtuV0U1SlFBaFVib1poam5DdTZNanFkaG9zTWgy?=
 =?utf-8?B?TDN5MEI1dzVIRk1DKytwUU1wS3ZSZjFDMitGak53QWRVZkVFWFRaTHRRemZG?=
 =?utf-8?B?a2NRdXVlcitGOC9uNmJHVUF2VUNFVFhkUHNrVmt1dDNWWkNicXdrZ0NMS05W?=
 =?utf-8?B?LzRuVFhZdlFidDlhdkZ0VUxzSC9scG9jby9zakdjdjRoeDlDaWxvdWU0VGxM?=
 =?utf-8?B?OE9BVUg5REJuazIwOGs2UEZpWUZBK3psTlhPWFdSbjB2SVRqR0V2M0VhdnR2?=
 =?utf-8?B?S3FYZ01EMmdTM3hXbVMrNmhENi9jaXgzL0piVkNKMkc2ZFUwcVBxY0YweVVD?=
 =?utf-8?B?eEgwTG9QM1pSOERvbElvcHB5TVd4UmljcUNwYnpxWGtCNVdYU3V5NTE3blRY?=
 =?utf-8?B?eU5EVlVmR0tvNlYwb0NaYThycm16OFNaeGVLZmZKTWw1VC9IL1ZUS25BMHZS?=
 =?utf-8?B?UjIxZFNYTmhlbENMU3VuNVJPVjAwUGNmQzArMEoramo3OW5CY3pOODlpOUo4?=
 =?utf-8?B?dG54MUJ3d2w4ck15Y09RWktkRlUyZHQrT0JpSmpLUG51VmhZOGRUNjBFYWd6?=
 =?utf-8?B?bGRMM0RMYXRSZzMyR3BlVWIxc0FiR0ZxRG5wM1cwYTFucVBSZ204SXFSQ2xl?=
 =?utf-8?B?cUdZNUhXb3Z2WVVJUGJZOW5HNElkSzNOVVM3ekVoVjJHWlEzKzJoK24yWStt?=
 =?utf-8?B?ZldTbEJSUENlMXF4QWhnRkEzdVRrc3d1ZDRENW1uZmRxeXdXM2pmbm5xOHV5?=
 =?utf-8?B?ckxYdkU3Tzl1L1pBUTdYczdPanlkdDZOUUpwRThzYXBsUi91enF2ejVFY0pr?=
 =?utf-8?B?QW5uT2xFSkwyZTdTZFZuc0dRRVZRZVRoUjdkOG1RbGJvTTd1K2lDVzhWcWU1?=
 =?utf-8?B?dHdHWDVWRXcxSEQ0TTFnTzJEdkNMMHdWWWI5UmM4b3Z1K3NCc1FFTnlTUXNG?=
 =?utf-8?B?d0VUcXhXVlNvSThpVnlxd2xGSHZDaExuOWkvY0xrUDFCTndTWmhMZmo2SHgx?=
 =?utf-8?B?dEp4TVp6OVVLbWQ5WmlsUWRCQ284VFJwc0k0SlF3c0h0MGxxTDJISGJPYURh?=
 =?utf-8?B?RVUzL3o5SFp1OVhEdHExZ3VjMm55bklQVTNrdklCY2g1VzFKcmFZNGNRUXNp?=
 =?utf-8?B?ZWFTdU9LcEQzU254dW9tVElsU2Q4Mlh4bThGTng0NlNGRTZEUVE4RmxaNklw?=
 =?utf-8?B?SlU0YUlvcTYyL0JwRXdicHA0b29qSHpVTC90YlhPdmZPSDU0SzVaR1FjTm96?=
 =?utf-8?B?SzgvcjdYVU4zQVlUdXNxRVM4bnRMVXhRaDdwbEZKQWw2OGcvcndFRldUb1do?=
 =?utf-8?B?TGpIb1FHajBQMnZSSXptVlRIRSt4d0tjTzlWL2orSHU3U2IveU1DU3FLUTFi?=
 =?utf-8?B?VGFnTGo5V2I0aHUybjA4dml3cVpLS0tJRTAyTE8vdTV3Y3RXdkpPdnNETlE2?=
 =?utf-8?Q?cNPEO/vQ7GlWUUvzi+vy2OBpa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49BFD0F2CD3A7C488EAC3E7FDBF2A1EC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3RuQlTtnOWyugkC9Fbzwl4u/Gs7n5/22RKi43wCwYGbOZWYDukK3zHJv+WXrN4ifijvd3Z1eJvUrpQulftItkIET9T2gXRTsQFA+sbj0t2ZkESp++A6+1tA+Nnn1/iiXqQCn/nkrO2pQOTtSKAAztr4u3YSG2B3Af8GSDEuvbjsLvP1Lfki52CtP3SfqRuk4mCe13bGTNjcpWnId8Y3/fJCTwgW1YG8o6OXkk6XtV3/FlNvnSGwnpN1q+sl7i+2/07bS6Ee+HtRyJtHXR1uVvdXJ+oML3g1S7W94Fgs46AGI9omZdPwQ2AXG3/F4gu1X7pmaREnwDwYkhvOecwoSwiQyrLEDtdtkMeWnOoCDFB3CoJ/i76fFmD5i9aQW+23XDROHrrbL4tuEsBBhHQqF7wK4Y60OulFc/6CaJIC5QIWC9Pynr3WONfnsXLG19+8mpfUpteOZBcuDDQnUyLw33lb6FnUN2uGVVhnmQXxX0FgZQe0R8pcDFKxCkG8b0+EFQi9Hwvq+rCUumvWeoW6RhgquDMo+P6UegBELt4nB24MrcPdI/+ooU9HW7LWGKEYYtG6oV+UKg3edUAaqoaEeteqIcosDqfJ+r6MCNKoSwhl3J5JOYwbIhfcpqThEDO/CQnKLUJ5zujqr28QOD8MZBa9CVB8Mja8kaUDCu66rnbqaIB8tqW2K4CPGgYSCCMIPYUp4AMjJYyKUmwina2SLKht0LFEoorHFTqdS07Uyl6iP46wFVKHiZO1SGe2dPoRbPFhKz8nP0b/CEd+TISv4LKAkQt03n7xi9eof0iY73uVsxF+I9AifVP8SVIOsEXjgq1BvfSnm2xCM+qxbDY3mZY3QeTQKPHnmUeru093glznGdv0Ch9qtJnt993gxTHuKlh74QKbI+sJ/uIhLwRtDhw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f6ed26-3e00-419e-93e2-08db5b09e2d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 21:17:02.1381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPDWeduBViYxvkI1vZoRIed9S9QcW96D7Mixa2cSt061Eg/zX47ncClB7gpQZe5Ew/CGbNzK0did5oKoxUTrdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360
X-Proofpoint-GUID: FFV4Angiy3lFrkomw4tX6s7E2NpoSKyw
X-Proofpoint-ORIG-GUID: FFV4Angiy3lFrkomw4tX6s7E2NpoSKyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 phishscore=0 mlxlogscore=589 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305220180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBNYXkgMjEsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEluIHRoZSBj
dXJyZW50IGltcGxlbWVudGF0aW9uLCB0aGUgY2hlY2tfZXZlbnRfYnVmIGNhbGwgcmVhZHMgdGhl
DQo+IEdFVk5UQ09VTlQgcmVnaXN0ZXIgdG8gZGV0ZXJtaW5lIHRoZSBhbW91bnQgb2YgZXZlbnQg
ZGF0YSBnZW5lcmF0ZWQNCj4gYW5kIGNvcGllcyBpdCBmcm9tIGV2LT5idWYgdG8gZXYtPmNhY2hl
IGFmdGVyIG1hc2tpbmcgaW50ZXJydXB0Lg0KPiANCj4gRHVyaW5nIGNvcHkgaWYgdGhlIGFtb3Vu
dCBvZiBkYXRhIHRvIGJlIGNvcGllZCBpcyBtb3JlIHRoYW4NCj4gKGxlbmd0aCAtIGxwb3MpLCB3
ZSBmaWxsIHRoZSBldi0+Y2FjaGUgdGlsbCB0aGUgZW5kIG9mIDQwOTYgYnl0ZQ0KPiBidWZmZXIg
YWxsb2NhdGVkIGFuZCB0aGVuIHN0YXJ0IGZpbGxpbmcgZnJvbSB0aGUgdG9wIChscG9zID0gMCku
DQo+IA0KPiBJbiBvbmUgaW5zdGFuY2Ugb2YgU01NVSBjcmFzaCBpdCBpcyBvYnNlcnZlZCB0aGF0
IEdFVk5UQ09VTlQgcmVnaXN0ZXINCj4gcmVhZHMgbW9yZSB0aGFuIDQwOTYgYnl0ZXM6DQo+IA0K
PiBkd2MzX3JlYWRsICAgYmFzZT0weGZmZmZmZmMwMDkxZGMwMDAgIG9mZnNldD01MDE4OCAgdmFs
dWU9NjM0ODgNCj4gDQo+IChvZmZzZXQgPSA1MDE4OCAtPiAweEM0MEMpICAtPiByZWFkcyA2MzQ4
OCBieXRlcw0KPiANCj4gQXMgcGVyIGNyYXNoIGR1bXA6DQo+IGR3Yy0+bHBvcyA9IDIwNTYNCj4g
DQo+IGFuZCBldnQtPmJ1ZiBpcyBhdCAweEZGRkZGRkMwMDkxODUwMDAgYW5kIHRoZSBjcmFzaCBp
cyBhdA0KPiAweEZGRkZGRkMwMDkxODYwMDAuIFRoZSBkaWZmIHdoaWNoIGlzIGV4YWN0bHkgMHgx
MDAwIGJ5dGVzLg0KPiANCj4gV2UgZmlyc3QgbWVtY3B5IDIwNDAgYnl0ZXMgZnJvbSAoYnVmICsg
bHBvcykgdG8gKGJ1ZiArIDB4MTAwMCkuDQo+IA0KPiBBbmQgdGhlbiB3ZSBjb3B5IHRoZSByZXN0
IG9mIHRoZSBkYXRhICg2NDM4OCAtIDIwNDApIGZyb20gYmVnaW5uaW5nDQo+IG9mIGR3Yy0+ZXZf
YnVmLiBXaGlsZSBkb2luZyBzbyB3ZSBnbyBiZXlvbmQgYm91bmRzIGFzIHdlIGFyZSB0cnlpbmcN
Cj4gdG8gbWVtY3B5IDYyMzQ4IGJ5dGVzIGludG8gYSA0SyBidWZmZXIgcmVzdWx0aW5nIGluIGNy
YXNoLg0KPiANCj4gRml4IHRoaXMgYnkgbGltaXRpbmcgdGhlIHRvdGFsIGRhdGEgYmVpbmcgY29w
aWVkIHRvIGV2LT5sZW5ndGggdG8NCj4gYXZvaWQgY29weWluZyBkYXRhIGJleW9uZCBib3VuZHMu
IE1vcmVvdmVyIHRoaXMgaXMgbG9naWNhbCBiZWNhdXNlIGlmDQo+IHRoZSBjb250cm9sbGVyIGdl
bmVyYXRlZCBldmVudHMgbW9yZSB0aGFuIHRoZSBzaXplIG9mIHJpbmcgYnVmZmVyLA0KPiBzb21l
IG9mIHRoZW0gbWlnaHQgaGF2ZSBiZWVuIG92ZXJ3cml0dGVuIGJ5IHRoZSBjb250cm9sbGVyLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWlj
aW5jLmNvbT4NCj4gLS0tDQo+IE9ubHkgb25lIGluc3RhbmNlIG9mIHRoaXMgY3Jhc2ggd2FzIG9i
c2VydmVkIHNvIGZhci4gQXMgcGVyIHRoZQ0KPiBkYXRhYm9vazoNCj4gDQo+ICJUaGUgY29udHJv
bGxlciBhbHdheXMgbGVhdmVzIG9uZSBlbnRyeSBmcmVlIGluIGVhY2ggRXZlbnQgQnVmZmVyLg0K
PiBXaGVuIHRoZSBFdmVudCBCdWZmZXIgaXMgYWxtb3N0IGZ1bGwsIGhhcmR3YXJlIHdyaXRlcyB0
aGUgRXZlbnQNCj4gQnVmZmVyIE92ZXJmbG93IGV2ZW50IGFuZCB0aGUgVVNCIGV2ZW50dWFsbHkg
Z2V0cyBzdGFsbGVkIHdoZW4NCj4gZW5kcG9pbnRzIHN0YXJ0IHJlc3BvbmRpbmcgTlJEWSBvciB0
aGUgbGluayBsYXllciBzdG9wcyByZXR1cm5pbmcNCj4gY3JlZGl0cyAoaW4gU3VwZXJTcGVlZCku
IFRoaXMgZXZlbnQgaXMgYW4gaW5kaWNhdGlvbiB0byBzb2Z0d2FyZSB0aGF0DQo+IGl0IGlzIG5v
dCBwcm9jZXNzaW5nIGV2ZW50cyBxdWlja2x5IGVub3VnaC4gRHVyaW5nIHRoaXMgdGltZSwgZXZl
bnRzDQo+IGFyZSBxdWV1ZWQgdXAgaW50ZXJuYWxseS4gV2hlbiBzb2Z0d2FyZSBmcmVlcyB1cCBF
dmVudCBCdWZmZXIgc3BhY2UsDQo+IHRoZSBxdWV1ZWQgdXAgZXZlbnRzIGFyZSB3cml0dGVuIG91
dCBhbmQgdGhlIFVTQiByZXR1cm5zIHRvIG5vcm1hbA0KPiBvcGVyYXRpb24iDQo+IA0KPiBJIGRp
ZG4ndCBzZWUgYW55IG92ZXJmbG93IGV2ZW50IGluIHRoZSBldmVudCBidWZmZXIgYWZ0ZXIgcGFy
c2luZw0KPiBjcmFzaCBkdW1wLiBBbHRob3VnaCB0aGlzIGNvdWxkIGJlIHNvbWUgSFcgaXNzdWUs
IEkgdGhvdWdodCB3ZSBjYW4NCj4gaW5jbHVkZSB0aGlzIGZpeCBpbiBzb2Z0d2FyZSBhcyB3ZWxs
IHRvIGF2b2lkIHN1Y2ggc2NlbmFyaW8uDQo+IA0KDQpXaGF0J3MgdGhlIEdFVk5UU0laIGF0IHRo
ZSBwb2ludCBvZiB0aGUgY3Jhc2g/IFRoYXQncyB3aGVyZSB0aGUgZHJpdmVyDQp0ZWxscyB0aGUg
Y29udHJvbGxlciBob3cgbXVjaCBpdCBhbGxvY2F0ZWQgZm9yIHRoZSBldmVudCBidWZmZXIuDQoN
CkNoZWNrIHRvIG1ha2Ugc3VyZSB0aGF0IGl0IHdhc24ndCByZXNldCBkdXJpbmcgb3BlcmF0aW9u
IChub3QgY2xlYW51cCkuDQoNCkJSLA0KVGhpbmg=
