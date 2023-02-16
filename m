Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E369A2C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 00:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjBPX6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 18:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjBPX6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 18:58:35 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728ED53813;
        Thu, 16 Feb 2023 15:58:19 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GMOk9j021916;
        Thu, 16 Feb 2023 15:58:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=ZwiMmWZ7pa47zlb1pBySnBcnj5jcxssebjBtMPEZAJs=;
 b=lMLVMju3CDQnPzePpeijaW5eULoS3UQsMWpaGKhjZLLm1x5wDFH4lWfFiGF87HklkDuG
 e8lVYB3x2kMIjV5d/sR7H4PY9o9+OARsvEjWBgZRvHezzD+9hQ7yfcTyXiOrNeyrK4f8
 gn1q8fBB95d9LQ/gSMDtsO1b2beOFythAVZlk3VvijedUsNJiQZ54IJzZpgOExJRs5sB
 F6iiW4UOQbzUcF6nYQRfsdnk+DbUzngSTA3cPhE7NzX5G0YjcxEGgYS0I+9i0FXzbxEi
 pXJY16b7odkkLPxhMvFgv2uwjSV3MF17jfe4mkqJEY2C84qS31NXzk2ckFNqt4hn2P+I pg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3npawuqvub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 15:58:12 -0800
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 717B8C00AF;
        Thu, 16 Feb 2023 23:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1676591892; bh=ZwiMmWZ7pa47zlb1pBySnBcnj5jcxssebjBtMPEZAJs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BIeErKSoxYWd14TmfmaEgOTsSt8Py8s19xEjJf2eeeoiaT1lpxYDPYrtOWAoRSMZg
         r2m1gRQQ3UiNzneHvgIj87O3LTrQFp9IQlnj/ZZbyUgM8CVF1AyZtlpEkMMdnDbBRe
         Vam/ChkoOpKXqD++jI2hsVGoNvFfLK9ZIk+9ALzvvEWv/BtJnEO/kpUqlsDM/7fx2p
         pAR3okNtufbf3YIEtUX6v6F6bpc/L8Zd7RonyvESx55n4dON0Yzz9AhQRf7a4G8N/b
         9y2ZsWi9/20OSV3pd3hVDlKasJuKvNcMl+urvqaORmqe42Yrqkgtxz0GHAgMq0vWjY
         jred6DGnNYIhA==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EA3E4A0081;
        Thu, 16 Feb 2023 23:58:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E810B800F6;
        Thu, 16 Feb 2023 23:58:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="a2r0jcu4";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWJDzuQerDmGJplSNRHxAmYJK/fd901Im8bkmTE1EUcTTYCd7bCk9t1Y3KzGKuzbivsi5UlagTw6sATA2Kr/GxEl9kphr2Eu3tS3qtvFnQaZxjzJWtZ0H/eYdSlEnDWptvMyIXz1/mRNZg6mHugz39EAE+G2d1NgHGIliUnDrrhbLo7ATxtQd1vZgJY86XO8qs63neKHKMAd1o8WHKhuW4rPhAhsCXFvRiSts6yXM86YcAVg1FrBTWXiwVevO7GGlc3oTFKefBpt37Q3/3ecFzki62jOTNPXdPmSNU6P6ShzfT5mnnzWZ0XMLKlUfmHHLGlo8WOwsyBNecnX01gdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwiMmWZ7pa47zlb1pBySnBcnj5jcxssebjBtMPEZAJs=;
 b=i2lrF4VGicjsQFqLCLz0tb90gOz1/4G4n8Au+55QqTv2p3sw6c165ZweXoNxMTMReWLgX50qJSOJT23PLQZ7BrP2ES/jYvtVTfwPtsgfSu/phQTo7j+q8kwjLWmdnARSiN5qoCel1dOBSTYVXZFQwngqBN1mOcQKeWtuQOgBor78BQx6gLSDG1ZWO7AZt1sXfmzwFwnpYfw3SVsKMniaU3mLXpzL+5XFB8gb/R/hFg9Opy1k2uJ0GIXAvcNCAFIjfcdtDs94c2YwBAJHVcR4BXfjXGrGjWLYtngxMhoAhdrFYTRKuYE8WZqcZd5nBtZjmBWSty5sGW+Nm+gEoFfYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwiMmWZ7pa47zlb1pBySnBcnj5jcxssebjBtMPEZAJs=;
 b=a2r0jcu4DMihz/qt/WdTLCMRJKjBwO6RZjkatG7l/xfKu5MGChEZPOSxV9FAeo8od2YWQu9lDV13iXDPRcORfX06atNwC/JkytBgWr3mVjr4AXLruwbT5+sNh1heP6nZoVmaNhxZC1ZKy1R2yr/XMXu9GnAHN2gPLwE0IaJsAGc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 23:58:06 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6086.021; Thu, 16 Feb 2023
 23:58:05 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v5 3/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH v5 3/5] usb: gadget: Add function wakeup support
Thread-Index: AQHZQlY4XOoXRUKvaEeTokZYNCs0ja7SQFGA
Date:   Thu, 16 Feb 2023 23:58:05 +0000
Message-ID: <20230216235759.ylqsrsyp3tpppmef@synopsys.com>
References: <1676586588-25989-1-git-send-email-quic_eserrao@quicinc.com>
 <1676586588-25989-4-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1676586588-25989-4-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB6686:EE_
x-ms-office365-filtering-correlation-id: cd4b07fb-4afb-48e9-380f-08db1079a5a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i0FYVK5s9QDWJmUGEUGdtbaoPZhgeiLr8ZJFV3vLqMWfDl4irlpKaOUqSfMrAZAnKwSosodOwKLfBpdqDEDE9BmE7ok9WaBMQ9tcJ9d+E+OBXdRMF92PkQXz+P7JaN5eHbfqfsL4cpWqeLc8LSVdghjOSXupvebaDFH6lpJn6HftFgvosP6hNqo5bkM9QXrI3M6gDl9Njg4TeSaEQIcdyT9Xr9c1wylFEaG5xVI6pSYtG8PwMPcIisz9EO3PbIxaPhJY8QXXjbbDa0Kfzsx2LfwGCbrQcgB+HA+zcqkb791sB7+GoqHx34rWUCDUaz9IGYbkjQG/utPVdVsa+i4DthHF2FIXiDkFxsbQp+nhM1EGZeSE6VdpSSigHyFQ4ejQTJBhjRSFP7wmodDPuAyX0czO2dDcPkKQc/0l69NRBBC3VkEGW+bjVY6PVD0v4P10FskfF2kq1951AhXf3Pn8J2y6Phb7c9yKFvsBDTQnpGNHtgDvKilJYwxxkICXaGdjyVUldB5TABszfQ/OsPKIFdTzOmOitmBLDEgJ3zZpfvkIWK7bfw2lq8HnB7vJ1S9pZsHbo6HWe782OwG/Fo3U/Ltl3P+7RUQIbtmWl3Vcea+aUgz2/LxLKsPEnVaVujJ1QWdO86BOFnHQPgtkwypqoTdnC9Gk55+M7JUfr0+CfUVv6Dr/L+e2C3Bz4co9zXmh6cpb8FfT0YpfyHDtYy16uA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199018)(64756008)(36756003)(8936002)(41300700001)(5660300002)(2906002)(76116006)(6916009)(4326008)(54906003)(66446008)(66946007)(8676002)(6486002)(66556008)(478600001)(71200400001)(66476007)(316002)(6512007)(6506007)(38100700002)(38070700005)(122000001)(2616005)(1076003)(186003)(26005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZExDSDlKOHUyTTVSdjUzaW4rV096OGMwVWN6a3E0dlFkK0srdTNHKzZMYTFj?=
 =?utf-8?B?Z3R5bGV0bmpIc1Y1eG81VFJSbU05Mk5ITWFwbnRmbnVxeXVwd2R1Q1c0dTNw?=
 =?utf-8?B?TTFZcHlDNG1qZVdVclYrTEZZdmtpOGdQSEpyNTBLcWoxb2VEUk8wY3hrdSs0?=
 =?utf-8?B?SnJWVW91SWoxWlVaREhqSTJlTkZ6cmhFNGVaeU1GdU9OQWVIbS9BdUNEYzVW?=
 =?utf-8?B?ajNJVlE2N1o2aUFGcDJIM2cwVkFvQnpDNGMzd3ovbTh6NXJZTEZSNThZVHQ0?=
 =?utf-8?B?dSt6dGQyZDJFTlQ2QzlGWm9lcnZMaGI5d2xIM1QxZnpybUFuelZ4MzFFaFds?=
 =?utf-8?B?UHJpRE9JcE5oMzF2UXd2ZUVZMFVsMzhNdzJvLytIVjN3MWlMcUNtV0VrYzVP?=
 =?utf-8?B?ekZsMUwzeFlkL09nRHdiaVExR204WUxNNDZMZHJUWFJBcGZEclkwL1k0aU1W?=
 =?utf-8?B?aEJaWUFHR1hRSkxyby8wbmgzNCtDeW5KTVduWkN1L0E4SXJuZDdEQWJUUDdx?=
 =?utf-8?B?S2dycFBiU1htaGdwN3ZUUm9BN0Mzd2pQYU95Uk5hRlNKRjlTa0RNWFpwc0U1?=
 =?utf-8?B?SUV2T3h6WXBIdUdSNUxDYk1vSnplRXJ2T3ovbW4vMHZDelkzQ0tiK2hXT3lY?=
 =?utf-8?B?bHd3dDI4Z0VtcVNiUW9BVUY1dFRybGtGTnpLNTNvNjhLbTdBSUNnNjlvTCtV?=
 =?utf-8?B?c0pDMENkdHBQcEpLcUFwUnIzcTJzaVFnSldjTVJveDFDUXR1WmRWVFpJaEd3?=
 =?utf-8?B?bCs3UVJUMEp3ZmFhYnNSblptYVovQjR2cDBCQ1gvSXF0WFRnQmZyNmY0UjBZ?=
 =?utf-8?B?SXAvMUVJdXdoOEpkaWxHNG0vYkJPbG9wdW55V2xXMWlqWVlhYWZ6TVNXK05a?=
 =?utf-8?B?RkFJbkZlMzNUUVdnU3dBYlBlWlJlZDVCNFh0eVc3OFFBVFBpQlpLbUM0ZGxi?=
 =?utf-8?B?d2VISUtvVGo4KzFhZ0NsUC9ValA5NGt1Slk0S1VFdzJRQkE2OVhZbHBuRWYy?=
 =?utf-8?B?T2FVKzBvZE1CQ2VxeTlDb2xCVVV3Q1czL1RmY0dBUzdzRXZOUFZPNkRKdUtK?=
 =?utf-8?B?ZzZIaE5VNkZyOERrbzIzN21aT0g2L2xMbjU4K3RUb1l3M0hxWEtxb254VjRw?=
 =?utf-8?B?YkR6eEF2WHZiNmxsQU4yU25hMVB1SHRmMldIRUw2WWpkRmdIYVREL2F1MFRM?=
 =?utf-8?B?YkxrUFpybjVSMHdmUXMyQ200Y0lYU2hnY1VVSkVERGdyT1FmQmhuUnQ5aldU?=
 =?utf-8?B?Zk11eVpqN3pjbCtGUGVmTklkT01hSzB6dnBXVmxhVXVJQ2VvWTRoYm85K0Rt?=
 =?utf-8?B?djJvWVFtYnFWUlJud0VjMEJXR3FUQTZwNGpZU2QyM1JwY0U0anFqNE5FUzdG?=
 =?utf-8?B?eTN5dE5aV1ZLdm1BZllpbDQ0OWxpTWRmNHRSeDliaHdlaXVCWkg3THM5WS9S?=
 =?utf-8?B?VVBMakJIUmxTQ09YVFRvcWtFUXcwUVpRU2FkcFZLVmI3UGI2Y2E2Qll5bkhi?=
 =?utf-8?B?VVdXQ3VBcXBFQmRieDdobFBNdWJuRUEyL3hub2NDTS9DVENHVm9xZlJDK0I5?=
 =?utf-8?B?d0VEakVEemRNMW5ndStkMzVFU3NkK1NIdDZBOURwbnhocWhlaWpmRUlUK0g1?=
 =?utf-8?B?YXVJWm1ISW1UOFp2d3VNcEZWRi9JQ0hpNC9BNmJ0bkV4SUI5MGFjcG1MNHc5?=
 =?utf-8?B?VnE3bmYrNFBLZTZCUjBrbXV1bnlXZTV0MzRrQVlVcTBIQU5vZGlYSmplUm9F?=
 =?utf-8?B?ZktKZkx5UzJXNlNxMTM1YzAyb1p2eFlkcEFoOGt6cHF6eEd0dzZMbXRPTlUx?=
 =?utf-8?B?dEdRaFJnRWYxLzBUR202WXB0L0lWbnJiSGdIZjBnc29XcVdMay9JVXRxSTZk?=
 =?utf-8?B?QjdZcFdoT3NKZmxQbG9NbXJSang2RDB3WmVWR2pyMUN0alpDWDBYaTNnVE1J?=
 =?utf-8?B?NnBnVmlmRlNLVWRaUm82R3pxZVNSTWxWcDk1VmFLcC9wa0p5ZjBYYnhGTUY3?=
 =?utf-8?B?SFByazUxWExleVllM1JNblpvOVR2VHZVcFltZCtQUnJ3TzBBREN4TGZwTDRV?=
 =?utf-8?B?V2hPSHFNVEpWOHYzUVdVVDhFZjRvNXFHd0V4VXRRVEZnN0lmWEg1Q25hdEhz?=
 =?utf-8?B?L0kwZjRRaVpZM3VyckROYnFDV3gwcWx2Nkx0Q1NhWmVvRGd1bms5UHNtNTg1?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A3967C24F7C834AAB090B137A701D3B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qbOvvHryosKt7lFaI/JifIPghVaPDLFw2dleANR28y9eeZWuNOQ/HcSpAAjRJnNyZShAJPGolB4oyMu0oP7LYOREI9CE3QTuwO/M0Qid9/4booAe9RYnsPFLbPds6xExLMhVrqnu5q/xk7dbJQsh76j4SUespCxNq4r9PKeY7z7Q22GEEOfMB+jfCiVPhz0/OjaNsBaeJQdoaIglxvjmqTivQK1nElAVsebjAN3zLIKv80tkYglj9ZgqiIzBOCD55vSHl5A3s/ZEqA+S1ncDYkje8peix52htKhuZnxoMASG/9svW2iNh4Py47uZwmpp8Qvpjeqc57czvIZno6fqA4y8cnbSNas2H8IoyCzU+MxmxE8QR9yqHl3cXWvSvTqDfVyrx6v+wegjUOrMVjFV1BLEk1GSw9ZHsTQY5X7nUvvA2vmyAfzdpBvevd+SlxSuYUnGjk2o9kVMKkeKAknsyXY1+vgKEC7knG/TY4IrCn1CaqlqI5CwwQNR3YpE7g6ShIUqRmKPZayIFlugdHDZdf+JqtwoThJwcwNQ/rVbpKBasHeeTDsAwxanCCzj7EFS56z09sAyYYWzuSVPb/O9GKrN8NSbS1FL33YRSayiAiKkk18xli6J9cY/kDcfBZ3NiZtMhyPLVBt1ejP7+ESR5NccgZmtRYXgClI5c5sMGsduKUm5gjnv6+JRPFZ/5V2E5XM1F+Kf9VMpFtKmBo6O8CFq0CoGLOTH5s+6f4fqBvQteXJZKWhjhkqyqOI5xtSsYsEUXhEh/R+uqhsdpyPSDCYtCjV3x3KJV2dmY7g3/XEKFoV0aMVk3o87HYDCgSi2+41b6qwb47ybTihHunJfeXRYWNrA3W/Q0KjPRuIngu9RJHjPQmn2hh5f4mf8UxUlVyErYin+mj/Ijdc5HQNNXzuPXeULGg2Cy0LZE3W0JuE=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4b07fb-4afb-48e9-380f-08db1079a5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 23:58:05.8900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fft/HMA1u67rMyb7yAida2N5LmZ7dEF+P5wxCtskCdh0NyAX4OW0WQwFzJT0hO2PLSDHge4GXEZK9pDCekfObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
X-Proofpoint-ORIG-GUID: oYFF_pL_8YgX6kKNFXge2z73hX9WJdqD
X-Proofpoint-GUID: oYFF_pL_8YgX6kKNFXge2z73hX9WJdqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_17,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 mlxlogscore=627 clxscore=1015 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160206
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBGZWIgMTYsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IEEgZnVuY3Rp
b24gd2hpY2ggaXMgaW4gZnVuY3Rpb24gc3VzcGVuZCBzdGF0ZSBoYXMgdG8gc2VuZCBhDQo+IGZ1
bmN0aW9uIHdha2Ugbm90aWZpY2F0aW9uIHRvIHRoZSBob3N0IGluIGNhc2UgaXQgbmVlZHMgdG8N
Cj4gZXhpdCBmcm9tIHRoaXMgc3RhdGUgYW5kIHJlc3VtZSBkYXRhIHRyYW5zZmVyLiBBZGQgc3Vw
cG9ydCB0bw0KPiBoYW5kbGUgc3VjaCByZXF1ZXN0cyBieSBleHBvc2luZyBhIG5ldyBnYWRnZXQg
b3AuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbHNvbiBSb3kgU2VycmFvIDxxdWljX2VzZXJyYW9A
cXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jIHwg
MjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Nv
cmUuYyAgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvdXNiL2Nv
bXBvc2l0ZS5oICB8ICA2ICsrKysrKw0KPiAgaW5jbHVkZS9saW51eC91c2IvZ2FkZ2V0LmggICAg
IHwgIDQgKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L2NvbXBvc2l0ZS5jDQo+IGluZGV4IGEzN2E4ZjQuLmY2NDlmOTk3IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMNCj4gKysrIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L2NvbXBvc2l0ZS5jDQo+IEBAIC00OTIsNiArNDkyLDMwIEBAIGludCB1c2JfaW50ZXJm
YWNlX2lkKHN0cnVjdCB1c2JfY29uZmlndXJhdGlvbiAqY29uZmlnLA0KPiAgfQ0KPiAgRVhQT1JU
X1NZTUJPTF9HUEwodXNiX2ludGVyZmFjZV9pZCk7DQo+ICANCj4gK2ludCB1c2JfZnVuY193YWtl
dXAoc3RydWN0IHVzYl9mdW5jdGlvbiAqZnVuYykNCj4gK3sNCj4gKwlpbnQgcmV0LCBpZDsNCj4g
Kw0KPiArCWlmICghZnVuYy0+ZnVuY193YWtldXBfYXJtZWQpIHsNCj4gKwkJRVJST1IoZnVuYy0+
Y29uZmlnLT5jZGV2LCAibm90IGFybWVkIGZvciBmdW5jIHJlbW90ZSB3YWtldXBcbiIpOw0KPiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwlmb3IgKGlkID0gMDsgaWQgPCBNQVhf
Q09ORklHX0lOVEVSRkFDRVM7IGlkKyspDQo+ICsJCWlmIChmdW5jLT5jb25maWctPmludGVyZmFj
ZVtpZF0gPT0gZnVuYykNCj4gKwkJCWJyZWFrOw0KPiArDQo+ICsJaWYgKGlkID09IE1BWF9DT05G
SUdfSU5URVJGQUNFUykgew0KPiArCQlFUlJPUihmdW5jLT5jb25maWctPmNkZXYsICJJbnZhbGlk
IGZ1bmN0aW9uXG4iKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICsJcmV0
ID0gdXNiX2dhZGdldF9mdW5jX3dha2V1cChmdW5jLT5jb25maWctPmNkZXYtPmdhZGdldCwgaWQp
Ow0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHVzYl9m
dW5jX3dha2V1cCk7DQo+ICsNCj4gIHN0YXRpYyB1OCBlbmNvZGVfYk1heFBvd2VyKGVudW0gdXNi
X2RldmljZV9zcGVlZCBzcGVlZCwNCj4gIAkJc3RydWN0IHVzYl9jb25maWd1cmF0aW9uICpjKQ0K
PiAgew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jb3JlLmMgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2NvcmUuYw0KPiBpbmRleCAzZGNiYmE3Li41OWU3YTdlIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NvcmUuYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL2NvcmUuYw0KPiBAQCAtODQ2LDYgKzg0NiwyNyBAQCBpbnQgdXNiX2dh
ZGdldF9hY3RpdmF0ZShzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KQ0KPiAgfQ0KPiAgRVhQT1JU
X1NZTUJPTF9HUEwodXNiX2dhZGdldF9hY3RpdmF0ZSk7DQo+ICANCj4gKy8qKg0KPiArICogdXNi
X2dhZGdldF9mdW5jX3dha2V1cCAtIHNlbmRzIGZ1bmN0aW9uIHdha2Ugbm90aWZpY2F0aW9uIHRv
IHRoZSBob3N0Lg0KPiArICogQGdhZGdldDogY29udHJvbGxlciB1c2VkIHRvIHdha2UgdXAgdGhl
IGhvc3QNCj4gKyAqIEBpbnRlcmZhY2VfaWQ6IGludGVyZmFjZSBvbiB3aGljaCBmdW5jdGlvbiB3
YWtlIG5vdGlmaWNhdGlvbiBpcyBzZW50Lg0KDQpEZXZpY2Ugbm90aWZpY2F0aW9uIGlzIG9ubHkg
YXBwbGljYWJsZSBmb3IgZVNTIGRldmljZXMuIFdoYXQgd2lsbCBoYXBwZW4NCmlmIHRoZSBkZXZp
Y2UgaXMgb3BlcmF0aW5nIGluIGxvd2VyIHNwZWVkIGFuZCB0aGUgZHJpdmVyIGNhbGxzIHRoaXMN
CmZ1bmN0aW9uPw0KDQpUaGFua3MsDQpUaGluaA0KDQo+ICsgKg0KPiArICogT24gY29tcGxldGlv
biwgZnVuY3Rpb24gd2FrZSBub3RpZmljYXRpb24gaXMgc2VudC4gSWYgdGhlIGRldmljZSBpcyBp
bg0KPiArICogbG93IHBvd2VyIHN0YXRlIGl0IHRyaWVzIHRvIGJyaW5nIHRoZSBkZXZpY2UgdG8g
YWN0aXZlIHN0YXRlIGJlZm9yZSBzZW5kaW5nDQo+ICsgKiB0aGUgd2FrZSBub3RpZmljYXRpb24u
IFNpbmNlIGl0IGlzIGEgc3luY2hyb25vdXMgY2FsbCwgY2FsbGVyIG11c3QgdGFrZSBjYXJlDQo+
ICsgKiBvZiBub3QgY2FsbGluZyBpdCBpbiBpbnRlcnJ1cHQgY29udGV4dC4NCj4gKyAqDQo+ICsg
KiBSZXR1cm5zIHplcm8gb24gc3VjY2VzcywgZWxzZSBuZWdhdGl2ZSBlcnJuby4NCj4gKyAqLw0K
PiAraW50IHVzYl9nYWRnZXRfZnVuY193YWtldXAoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCwg
aW50IGludGZfaWQpDQo+ICt7DQo+ICsJaWYgKCFnYWRnZXQtPm9wcy0+ZnVuY193YWtldXApDQo+
ICsJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gKw0KPiArCXJldHVybiBnYWRnZXQtPm9wcy0+ZnVu
Y193YWtldXAoZ2FkZ2V0LCBpbnRmX2lkKTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHVz
Yl9nYWRnZXRfZnVuY193YWtldXApOw==
