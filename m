Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667B673EF71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjFZXq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 19:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFZXq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:46:56 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019F71998;
        Mon, 26 Jun 2023 16:46:54 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QNAsFq001541;
        Mon, 26 Jun 2023 16:46:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=7yrVF0zqD7Iv6ZUNRlrb7rUv+DNkI3nYi54va6Nv6eU=;
 b=oSvh/BkVypgaSeWm3MWqhd2Ja4v06qZatFYe4Dnl6CGhDKblsDuf9lD+V0gPe6Jj6xYK
 dZfFcEWa4z+1SwDyWHJdQJy/B1bpv2mBT8LgKzFCjNdkltmmBYKBpejX1g+kRiCkxvY7
 ddXQ1r6/OAWfKYkyok0aDz/gjhaA3NxmkhiM4/PAzhG8bt0QSG/NXFDSS49i5tTQgGw/
 Y/o1m9IWg699LY5tUZ0SRz4NlMR542v0DWUeSroswph6/nmDULPwzR/wIaPOukPLB3+G
 ATX/UsNJ9E1VX1xLszIYfDZ9ZW5i6M4FwFiG69LiLBs4PvLANprBu8Lslgy1fNyl8f4B Mw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3rdy4e3g4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 16:46:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1687823197; bh=7yrVF0zqD7Iv6ZUNRlrb7rUv+DNkI3nYi54va6Nv6eU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=evEHOECM1/b2JwLc4i7+vjliVA7hDYW5qUFJZQbddu5htcx9DucW2cL6c7iNHLY5r
         ixjUnq9qCKvdkiDMzbUaEMJ+bSLFSXp1/Cfe/hQvAmzi5qx3+uAeYLCBBTcgi0zL6D
         m3nzagOwLxCNJyWHmbHTraeg5b9p7LbOjgULnNkbbMiYMT7+BAoWFLZWskRwmPlBDO
         zRLzzJsvN3x2AL0oDJJZzHg6ONpYbkxlSmfCNa+uGAkVEgwc3nqgbrhcGMy+o+C+ur
         NPjtofHLriFOlUHBagKv9kTtEGOddkI5KLV79o/LHI0hMjs+smtxPVnBQrH8aHCDvA
         AIT9044vGf8mg==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 95C3B4011F;
        Mon, 26 Jun 2023 23:46:36 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 46FECA007A;
        Mon, 26 Jun 2023 23:46:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=hKsBO41x;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EAB3A40407;
        Mon, 26 Jun 2023 23:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyPceeIAaJzyAndYd8l7SOSXzHP5FYIvKB1GlYzd+l9YFNUUBg5usvZ/5DDgWv/ls6VOMd/kEo20+LIOpV2DFwy2AZlci88pIvWKz7m/3M0pFDZTVYFGtb5TkkydAwSz8p9H1Sv1I0sAJ4UW6Vm0iNFK6PUbV/exffgkr5TXU2PnSQSJNu8zfqE+vIrGuJQT30+EBrmQYM2bDmwCV2JA663X0wqtZxP+O5/jLclsBkCwQVbY5D1/zWYpWg3efi3ZxlZSRyp8Vjbq00vRcb7VlZyHI+TERwCC1NC7Umgu4BXSRsa4Ox8Iqf/Y+YyneLzUCphH0X2ldWHGPOchDCRgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yrVF0zqD7Iv6ZUNRlrb7rUv+DNkI3nYi54va6Nv6eU=;
 b=MgoXEChFKAM6rGL1vEemnivTZxnbbOuTNx0xggYkV2Me5daEON3Re+x5orXiMzu5qM7IvO5gNaAC3DiaVoe9Ghlf8WfIdJKnMoead3n3qv5CiwQLEHWQ91q0KfJaoi1lauXQC/+4KRMpn/SdIZRD8P6s7q2o0frjexwjkRE4K9eewyugBUAHZugvu+LpM6t/QPStQzeIB2FQZjSQnRC827FR0GKiMHn9TTAZrZGLVegiRYVMScd0iwSqhTk/UCT62ZG4BF1f9pMISlQnQ1uIPXE8h8ljDr8FsjnXTSd2rpy0nQretcpY7aPbdCjvbvpJkRWmMsnf9cORui4fizDdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yrVF0zqD7Iv6ZUNRlrb7rUv+DNkI3nYi54va6Nv6eU=;
 b=hKsBO41x97QItyAj6oAqYenkYrAmOk6kmsXFyrw4loH4D3T0gCJvjFcAZySVh6LMv1RKSqGX9kVjTiNiinnB3o6I3t5TIBQ07M21ynpvt9e5Ozkljqf8qEjMKZYyjW9VkPkEKGX93AjzxeK6ewusR+kJMAKf+y/LY4V6S/YYAds=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:46:31 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 23:46:31 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v9 04/10] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Thread-Topic: [PATCH v9 04/10] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Thread-Index: AQHZo/oUWyyJ3lQGykedS+ST62GFCK+Y+/MAgACUuQCABDTaAIAAA10A
Date:   Mon, 26 Jun 2023 23:46:31 +0000
Message-ID: <20230626234626.aqhaluh6wnat6gxx@synopsys.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-5-quic_kriskura@quicinc.com>
 <20230623222754.auuce7y6c2e7ymvw@synopsys.com>
 <19932a93-4fc8-f177-8cd6-b6ecd5e163c2@quicinc.com>
 <20230626233424.2flncnsvfzb2ccbt@synopsys.com>
In-Reply-To: <20230626233424.2flncnsvfzb2ccbt@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB5087:EE_
x-ms-office365-filtering-correlation-id: bd52a7ec-e705-4355-7475-08db769f9132
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5oLRmS3QSTP7EvA0O4yDpncodjKc7IpDCKtcvscRUPI5pkeWb4kO+/YuRdpu3H5/Hj/2R62mUZUvXLsRL4QiU0pSZ6dXq2GfEG+WI9q+JBLFVNSoRjioHl/DphtLj15RGuUJ7JND5g5NHWxwl3i4wA12e7V6CdhEqd+79g9M9NC7G5xtRpzc1MPSwlmAp9/H7hQckEPgf60mSHQ8uNZhL0y4EhXdI23cMYMTl+SD20/AGrgKEbQQIQbx622OLVB6/dPmDulvUr24QFMOjgqk/zs0C4esqUP1FDPbh3CHrB/dkuzzJxoqFTdK5bO8y+Rs6aIVPWZGdVsu8Q7YQMQ114sMa/G/0UClPo6KR4Hm4qXyK2u+gnxYURCqkvp7yF4FxYbS3wCzgHuc7IlSuODXjPJQuTPgBMwemL8f9wUZSRCh1DYa6Ao4wPZQgbtMVrJrsbQX+7DEoZgDafsrZMGKrTEHW0o76y4g0WDk/CPpZKDwcwGSxvptAdnwEZQFXeWEH3FXJawz6Z5L7z+8taJ0TT9Gh9wHIXJYZysGhyDkJvD1BRzyONLQk35490GnSbRVIpO6smPL9FSB0O0SaHAbXEBz7P2wRq+388Rz3ZXga4vJWiwze0bDjMWNeFOgCO97
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(66556008)(36756003)(6506007)(6486002)(54906003)(478600001)(2616005)(83380400001)(66446008)(26005)(186003)(53546011)(1076003)(71200400001)(2906002)(5660300002)(7416002)(122000001)(316002)(64756008)(38100700002)(66946007)(76116006)(91956017)(8676002)(41300700001)(6916009)(86362001)(8936002)(4326008)(66476007)(38070700005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWhkdEllWWNRWWJaa01kK2p1RUtPcFNhdGlBZzUwOUNZdEh1bzZpcWVPTG5N?=
 =?utf-8?B?MTNadmVwL2hKODdod0p6ais5eTB3Zk1LbTduY3VqRndpbUJ5L1o5M1NFZW5T?=
 =?utf-8?B?RDFPK0xGSEhUb1YwL1RYOXVReUgzc1U2K0Q1citkRHFZejFsK09BaFFlRlli?=
 =?utf-8?B?QXdncG8rbURqK3FHNlYzbjhuQytKaW1xTUZRUzZUaU9xQ3BDMS9XQ0FHTE5Z?=
 =?utf-8?B?MXFkM0Z5dWhOaHpZY2RsYUtsaTgvOHFrU0VPWDNwTDdUQ0FqZGN6Z2Fidkxp?=
 =?utf-8?B?MFZXTWhkUkFtVVZWVHlsNk1kY1l3NU1DcUVQQ3BIV2VtWSt3Zmp0S3U5TEVk?=
 =?utf-8?B?N1FCcmhYbUlCV2djcU5sdnNLR1ErTElCOUh2dG9HMW9KUVFQRzkvY2pRQVlF?=
 =?utf-8?B?Mnh5Q3p0WnhmU3hWSXFvWlJBUHk3ME44SkU0NytKMXo5eFhSdzdZQ3EzWmJa?=
 =?utf-8?B?TG9BUlJuRmtIR0hldXE0ekN0ZEg0Z0VoYVRNQ2Ztd1JLK05NMFI5VzJoU2xt?=
 =?utf-8?B?dFlWNnRvQ2FUc1ZqZXlWVytUNlVxSEVpS0pTRFJ5MWVYWGMreDdkV2ZVRXFY?=
 =?utf-8?B?VTNFck1maEgvWkRhL2xSdEZhNmg3dll5OGY2dXEwcGVVUzBIQ0NkU3JzeEtL?=
 =?utf-8?B?MHRtQUl0VzA5R0hrQ1I2aktoSDlMcWxqMGRDQjBDQUMzWXV5dDBQalNoYTRU?=
 =?utf-8?B?S3VtUkxRWllRM2hHejV6UWFjaUc5TzV1UWh6cFZEVEV5ODkvRDhQaFFLZU0v?=
 =?utf-8?B?RjNmamt0TFZDcG1oR0h2NWJ1aytmT2ZPanRxc0RWaTEzV1dEOVI2SERvcmkx?=
 =?utf-8?B?SHNrVSt0ZEJlTjlISWlWS3Q1ZkRiV0tlMk15QWx3cTE3NXQxb0UrTlZhajNI?=
 =?utf-8?B?WGIweEcyT3J0akJnU1VrbHJOZHZlMU5yK1JDclNpSXZ4dG1kdXFrTFVJeHhH?=
 =?utf-8?B?Szh6VUpraDFtY01NMVk1QStWK0NJWEZxZHRybURaMllFZDlMdUZxL3p3QktI?=
 =?utf-8?B?NDkxWktmM2tVWkE3NWgzVGNaNUhPMS84cVhvUDlWN1N6UVMzVjNZRFVaTlYz?=
 =?utf-8?B?VHE0d2E0WGJzUTNaYUVBSWc5VElGUWdUeUJORjJyLzVzTnR1UWh3UHpFbTky?=
 =?utf-8?B?bTAvS3NTcjZCaVB6ZTE1QlYxYTFsOFVEUFplMnNFbTNPejNzYUduQm1pZ1VM?=
 =?utf-8?B?VkQwdWVxbC9VTitOME1ZUCtGVjZNYWdOZXJTWkhaOGR2OUtDUEdhOWlWRmVF?=
 =?utf-8?B?cEIxbE0rcVdVRnF0Sm5nUnJ3NSsxQmhOTzR5a0ZOUW5CM1JFQTZYZm1Sc0lG?=
 =?utf-8?B?MzJiOXBmYk81Wk9Sb3prOHIwS1F5UXBMVURYa1poanJtYzM5NndnSFk3amRo?=
 =?utf-8?B?N29IbXFRTVlrZkpmYXdVK2RqS01FSjZWcG5WeTR3Q3ZtNHFxVGNJUFBtSW5U?=
 =?utf-8?B?b3FUZjJLK3FwK2dQZUdsbXYzL1BMWUVDZDB0SHZtQWlsZXE5aGh2dEhSZmRT?=
 =?utf-8?B?eW9RcUNtWWpiNDZXd1R6Nk5mbzFtUnVsQTk4Nm5BRjFLRDdHMnhpR093eEFZ?=
 =?utf-8?B?ZHB3RWIyS09VSS9URExjTEN4d0pUOUhZUDd4U2xiMGJqeE84OEovSThsL3Mz?=
 =?utf-8?B?RjA3UGdBYTYyU2NJWjVxaUdla2ZaRko1TktkQ09IM1BYeWVKZ3hKZXRoYXVH?=
 =?utf-8?B?WnBlMWorbmRLR3Q2dGZrUDVkdnRtRElzRHRMYlhBNE5sbHg0eTh6SWlJRXdk?=
 =?utf-8?B?RmRtaGZxMHFodjBlNHViRjNDeXE1VU13bUlNT0gyOVBISWpiM0ZiV3lJTlk5?=
 =?utf-8?B?ZkRWNC8xQ1ZNL3hOa0NDK2grbXVpQmpkN0FvcnNQQnZUMUVrS3h4NTUraWZr?=
 =?utf-8?B?Sm1ZNlVCcjUvMytvQVpjYXdTd1ZzWWVIRit3TnQ3TVVuWndKM2xGUDQ1U3Nv?=
 =?utf-8?B?ODhWdHc0NTd0YjJaSUpCdi9QY28xcVNrSnNzcDFUL2ViQ0ZyeWdwb1M0Q2ZL?=
 =?utf-8?B?TTc3aEJUTWN4cnVVQWtmN0JBdzVwTkRPREdJQS95bm1tWFpxeVhnclM5NnJL?=
 =?utf-8?B?am1jMTA3d3UwU202eEgrRUo1aFJweHNRMUsvenE3aUNaTXY4RGlaQzRMak13?=
 =?utf-8?Q?aR+8iuSKLNKn93Zg2DloHzFVz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D89C281E2FC94B478C08E06C813613B0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cHB1V2FPL2ZvY1hqaUVuSjgvbTZLb1FsOHNHdnQvTE1jVFBKbXFXL2JFVWlP?=
 =?utf-8?B?M0VyTVlsSU13a1lvZ3J4dzRuQUpkRDJrRFhJMkdYQ0pIcmZDQzFOWCtlMC84?=
 =?utf-8?B?L2lDLzRmNFdHREoxaXUvc3FCQVdYd2JlVDNJMWwxQTUxUlBjSE5ucG5teGty?=
 =?utf-8?B?clI1dTl2UnlMM0d4eWpIZE42Y1ZkN1QrTWJKM0hCWm0zbmxXclRST2Q1QXlw?=
 =?utf-8?B?QnhoS1hFQ1RlUzZzeFAzS1hRUmtvVkNXT25KK0V6T25nako1bkN6UTVOcEls?=
 =?utf-8?B?RHQwakI4elkzcHpwYXRnYldQeFRGNWJXTUwwU1ZTN0ZOUnRnZk5FME16Wks4?=
 =?utf-8?B?VGpValZqUGFqQzc1cnVOK1lYVmxGZnZMMW9zQ2gxQjBvSnNuM3RPcldRUmlY?=
 =?utf-8?B?bEZTREZYb0VUSndJMDY5U2Vid3o5dHRHSCs0Z3RpWUtmRStTSTlZbTNTT0dh?=
 =?utf-8?B?TkhsajgwZEVkaVR1ZWN5NmJxZ1ZaTEZTZWluUjdDNG85UFFyZkQzM1lYdTZ4?=
 =?utf-8?B?cStvSmU4WXJrVFl4SmprdlJKS2VNU2FSN1Zzc3BvaHdObHFQOXh6clVKZHRB?=
 =?utf-8?B?RjR1SU1QWGZ6T2YrM3dlT1BZZ2R6SDhXVk51cjhuVy9iOUFSVXA0RTVmelVN?=
 =?utf-8?B?VTJiRTVNVng3ejlsdDdJM0FLYVlsR1B1aHRIUG11ZHYzbHVlOW5JVWc3VC9r?=
 =?utf-8?B?Nmp6RkNUdGEwV2ZOcXZKUThYSWFxNGo5d1oxNUpVVXVhU2YwMldYSWpKN1JE?=
 =?utf-8?B?dk5RRThLd0tnS1RRRFE3N1NIdmZ0S3N6RThYV05rWDNIYkxwMDBoRW5vSWlJ?=
 =?utf-8?B?dlU4VzFadHVZSHZzaGVwa2ZVRXBrSko3bFNoZG1HcDF1NFNQNHF3WWh4MHNt?=
 =?utf-8?B?WlJsc0J2UnMvR21XR3JJalVWWW5FV0RXS1g4Q1llZFZZVGtPVjVkZGZkNk83?=
 =?utf-8?B?bTNLUkw3U3V0d05QRTIrbG55Z2JsVk9mZFdjbU5IUldXWTBJUWhUQ21rYUVO?=
 =?utf-8?B?UlBjdm5LZnhVVndiYjIxemZ6NXlkdHVDdkp1cVJpVmZIWndwd0p3dU5XdEdq?=
 =?utf-8?B?Wm1aYjc3YmlQczFvSzg0QjMxaGFhb2UvbmRzblBkdytKdkh3QnJtbWU4eU5L?=
 =?utf-8?B?cmFVbnhKcXpNZEN6eW9qcFlQTW4zMjBkUzd2VDQwYnFRK1NVaWNUZm0yY0FZ?=
 =?utf-8?B?RDdCU0FJenNXVWNhclZidmVzM2dUR2VCLzJmcEZpQ2RORHZxTUQyNEQ5NEkx?=
 =?utf-8?B?WXhGZVc2T2hoYm9JM050S3NMRjhOUHFmMnVXQ2ZGWktGZGZKVjRJU015RTVj?=
 =?utf-8?B?SHNBSjhqSlRyRXJFRWpmTkliRGJxQUhkUWlLOXNtR0xKUjdaMXVUclArcjkz?=
 =?utf-8?B?Q0p2U24xWjJoZ2c9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd52a7ec-e705-4355-7475-08db769f9132
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 23:46:31.0920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lHNRlPLZgMqhfeBOk1ALRkUuTQ/ecHpVnnCPd8DcXghPcH4pvMUsSpEK9aGE9ywI5AwwHyKDxfWf3wfVGiB2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087
X-Proofpoint-GUID: ujWgZHqnZVkjsW06rBKJAvvbjUvm-J7t
X-Proofpoint-ORIG-GUID: ujWgZHqnZVkjsW06rBKJAvvbjUvm-J7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_19,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260220
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdW4gMjYsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gU2F0LCBKdW4g
MjQsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+ID4gDQo+ID4gDQo+ID4g
T24gNi8yNC8yMDIzIDM6NTcgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+IE9uIFdlZCwg
SnVuIDIxLCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIHdyb3RlOg0KPiA+ID4gPiBPbiBzb21lIFNv
QydzIGxpa2UgU0E4Mjk1UCB3aGVyZSB0aGUgdGVydGlhcnkgY29udHJvbGxlciBpcyBob3N0LW9u
bHkNCj4gPiA+ID4gY2FwYWJsZSwgR0VWVEFERFJISS9MTywgR0VWVFNJWiwgR0VWVENPVU5UIHJl
Z2lzdGVycyBhcmUgbm90IGFjY2Vzc2libGUuDQo+ID4gPiA+IFRyeWluZyB0byBhY2Nlc3MgdGhl
bSBsZWFkcyB0byBhIGNyYXNoLg0KPiA+ID4gPiANCj4gPiA+ID4gRm9yIERSRC9QZXJpcGhlcmFs
IHN1cHBvcnRlZCBjb250cm9sbGVycywgZXZlbnQgYnVmZmVyIHNldHVwIGlzIGRvbmUNCj4gPiA+
ID4gYWdhaW4gaW4gZ2FkZ2V0X3B1bGx1cC4gU2tpcCBzZXR1cCBvciBjbGVhbnVwIG9mIGV2ZW50
IGJ1ZmZlcnMgaWYNCj4gPiA+ID4gY29udHJvbGxlciBpcyBob3N0LW9ubHkgY2FwYWJsZS4NCj4g
PiA+ID4gDQo+ID4gPiA+IFN1Z2dlc3RlZC1ieTogSm9oYW4gSG92b2xkIDxqb2hhbkBrZXJuZWwu
b3JnPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNr
dXJhQHF1aWNpbmMuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gICBkcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyB8IDExICsrKysrKysrKysrDQo+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKykNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+IGluZGV4IDMyZWMw
NWZjMjQyYi4uZTFlYmFlNTQ0NTRmIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4g
PiBAQCAtNDg2LDYgKzQ4NiwxMSBAQCBzdGF0aWMgdm9pZCBkd2MzX2ZyZWVfZXZlbnRfYnVmZmVy
cyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gPiAgIHN0YXRpYyBpbnQgZHdjM19hbGxvY19ldmVu
dF9idWZmZXJzKHN0cnVjdCBkd2MzICpkd2MsIHVuc2lnbmVkIGludCBsZW5ndGgpDQo+ID4gPiA+
ICAgew0KPiA+ID4gPiAgIAlzdHJ1Y3QgZHdjM19ldmVudF9idWZmZXIgKmV2dDsNCj4gPiA+ID4g
Kwl1bnNpZ25lZCBpbnQgaHdfbW9kZTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWh3X21vZGUgPSBE
V0MzX0dIV1BBUkFNUzBfTU9ERShkd2MtPmh3cGFyYW1zLmh3cGFyYW1zMCk7DQo+ID4gPiA+ICsJ
aWYgKGh3X21vZGUgPT0gRFdDM19HSFdQQVJBTVMwX01PREVfSE9TVCkNCj4gPiA+ID4gKwkJcmV0
dXJuIDA7DQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgYSBsaXR0bGUgYXdrd2FyZC4gUmV0dXJuaW5n
IDAgaGVyZSBpbmRpY2F0ZXMgdGhhdCB0aGlzIGZ1bmN0aW9uDQo+ID4gPiB3YXMgc3VjY2Vzc2Z1
bCwgYW5kIHRoZSBldmVudCBidWZmZXJzIHdlcmUgYWxsb2NhdGVkIGJhc2VkIG9uIHRoZQ0KPiA+
ID4gZnVuY3Rpb24gbmFtZS4gRG8gdGhpcyBjaGVjayBvdXRzaWRlIG9mIGR3YzNfYWxsb2Nfb25l
X2V2ZW50X2J1ZmZlcigpDQo+ID4gPiBhbmQgc3BlY2lmaWNhbGx5IHNldCBkd2MtPmV2X2J1ZiA9
IE5VTEwgaWYgdGhhdCdzIHRoZSBjYXNlLg0KPiA+ID4gDQo+ID4gSGkgVGhpbmgsDQo+ID4gDQo+
ID4gICBBcG9sb2dpZXMsIEkgZGlkbid0IHVuZGVyc3RhbmQgdGhlIGNvbW1lbnQgcHJvcGVybHku
DQo+ID4gDQo+ID4gICBJIHRob3VnaHQgd2Ugd2VyZSBzdXBwb3NlZCB0byByZXR1cm4gMCBoZXJl
IGlmIHdlIGZ1bGZpbGwgdGhlIGdvYWwgb2YgdGhpcw0KPiA+IGZ1bmN0aW9uIChhbGxvY2F0ZSBp
ZiB3ZSBhcmUgZHJkL2dhZGdldCBhbmQgZG9uJ3QgYWxsb2NhdGUgaWYgd2UgYXJlIGhvc3QNCj4g
PiBtb2RlIG9ubHkpLg0KPiANCj4gVGhlIG5hbWUgb2YgdGhlIGZ1bmN0aW9uIGltcGxpZXMgdGhh
dCBpdCByZXR1cm5zIDAgaWYgaXQgYWxsb2NhdGVkIHRoZQ0KPiBldmVudCBidWZmZXIuIElmIHRo
ZXJlIGFyZSBtdWx0aXBsZSBjb25kaXRpb25zIHRvIHRoZSBmdW5jdGlvbiByZXR1cm5pbmcNCj4g
MCBoZXJlLCB0aGVuIHdlIHNob3VsZCBkb2N1bWVudCBpdC4NCj4gDQo+ID4gDQo+ID4gICBJZiB3
ZSByZXR1cm4gYSBub24gemVybyBlcnJvciBoZXJlLCBwcm9iZSB3b3VsZCBmYWlsIGFzIHRoaXMg
Y2FsbCB3aWxsIGJlDQo+ID4gZG9uZSBvbmx5IGZvciBob3N0IG9ubHkgY29udHJvbGxlcnMgZHVy
aW5nIHByb2JlIGFuZCBub3doZXJlIGVsc2UuDQo+ID4gDQo+ID4gICBBcmUgeW91IHN1Z2dlc3Rp
bmcgd2UgbW92ZSB0aGlzIGNoZWNrIHRvIGR3YzNfYWxsb2Nfb25lX2V2ZW50X2J1ZmZlciBjYWxs
DQo+ID4gPw0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gS3Jpc2huYSwNCj4gPiANCj4gDQo+IEkn
bSBzdWdnZXN0aW5nIHRvIG1vdmUgdGhlIGNoZWNrIHRvIHRoZSBjYWxsZXIgb2YNCj4gZHdjM19h
bGxvY19vbmVfZXZlbnRfYnVmZmVyKCkuIFNvbWV0aGluZyBsaWtlIHRoaXMgc28gdGhhdCBpdCdz
DQo+IHNlbGYtZG9jdW1lbnRlZDoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDBiZWFhYjkzMmU3ZC4u
YmJhODI3OTJiZjZmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMTc3Myw2ICsxNzczLDcgQEAgc3Rh
dGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJc3Ry
dWN0IHJlc291cmNlCQkqcmVzLCBkd2NfcmVzOw0KPiAgCXZvaWQgX19pb21lbQkJKnJlZ3M7DQo+
ICAJc3RydWN0IGR3YzMJCSpkd2M7DQo+ICsJdW5zaWduZWQgaW50CQlod19tb2RlOw0KPiAgCWlu
dAkJCXJldDsNCj4gIA0KPiAgCWR3YyA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqZHdjKSwg
R0ZQX0tFUk5FTCk7DQo+IEBAIC0xODU0LDExICsxODU1LDE2IEBAIHN0YXRpYyBpbnQgZHdjM19w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJcG1fcnVudGltZV9m
b3JiaWQoZGV2KTsNCj4gIA0KPiAtCXJldCA9IGR3YzNfYWxsb2NfZXZlbnRfYnVmZmVycyhkd2Ms
IERXQzNfRVZFTlRfQlVGRkVSU19TSVpFKTsNCj4gLQlpZiAocmV0KSB7DQo+IC0JCWRldl9lcnIo
ZHdjLT5kZXYsICJmYWlsZWQgdG8gYWxsb2NhdGUgZXZlbnQgYnVmZmVyc1xuIik7DQo+IC0JCXJl
dCA9IC1FTk9NRU07DQo+IC0JCWdvdG8gZXJyX2FsbG93X3JwbTsNCj4gKwlod19tb2RlID0gRFdD
M19HSFdQQVJBTVMwX01PREUoZHdjLT5od3BhcmFtcy5od3BhcmFtczApOw0KPiArCWlmIChod19t
b2RlID09IERXQzNfR0hXUEFSQU1TMF9NT0RFX0hPU1QpIHsNCj4gKwkJZHdjLT5ldl9idWYgPSBO
VUxMOw0KPiArCX0gZWxzZSB7DQo+ICsJCXJldCA9IGR3YzNfYWxsb2NfZXZlbnRfYnVmZmVycyhk
d2MsIERXQzNfRVZFTlRfQlVGRkVSU19TSVpFKTsNCj4gKwkJaWYgKHJldCkgew0KPiArCQkJZGV2
X2Vycihkd2MtPmRldiwgImZhaWxlZCB0byBhbGxvY2F0ZSBldmVudCBidWZmZXJzXG4iKTsNCj4g
KwkJCXJldCA9IC1FTk9NRU07DQo+ICsJCQlnb3RvIGVycl9hbGxvd19ycG07DQo+ICsJCX0NCj4g
IAl9DQo+ICANCj4gIAlkd2MtPmVkZXYgPSBkd2MzX2dldF9leHRjb24oZHdjKTsNCj4gDQoNCkFj
dHVhbGx5LCBwbGVhc2UgaWdub3JlLiB0aGVyZSdzIGFscmVhZHkgYSBkb2N1bWVudCB0aGVyZSwg
SSBtaXNzZWQgdGhhdA0KZm9yIHNvbWUgcmVhc29uLiBXaGF0IHlvdSBkaWQgaXMgZmluZS4gVGhv
dWdoLCBJIGRvbid0IHNlZSB0aGUgY29uZGl0aW9uDQpmb3IgZXZfYnVmID0gTlVMTCBhbnl3aGVy
ZS4gQ2FuIHlvdSBhZGQgdGhhdCBmb3IgY2xhcml0eT8NCg0KVGhhbmtzLA0KVGhpbmgNCg==
