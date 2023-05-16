Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D470A705AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjEPWkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjEPWkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:40:05 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EED672AA;
        Tue, 16 May 2023 15:39:52 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJqrUv013660;
        Tue, 16 May 2023 15:39:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=53jNvPUsxQBtSbRsbMy5QztIX6K5o4vByir7RxPH66U=;
 b=HZqRy9R7MKrBRQc18TRvT8FKlrdDOmWTggVtnqtYJb69oNyBp1TQe2b+cBjBrw4z0TEt
 VE1fy1KE3UV8WoHysBxPhbjVbID3+e0VjSCkX/UsNUMvdYrKHuel394W7/PbCZvUIChT
 KNNiwaWgd/4VzO5pjc1hRGiVCaPtR2TvY4j3ll0CyW0MAq+vdJVISTuOiJOneO+Tu1YE
 H2zqpZy6Q+80gt8sTR6+sSR0x3qzPoLxaf4NwcxRrLaQCncRhpDLo9uJrcTDakzeTlU3
 xDwq8jMasD9DBRDXwPVDDV9TpHXukQL3N1eZthTOQO5Tvs3QtuhvDVgHPB+CBczM3R+p Ew== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3qj96eh74g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 15:39:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1684276770; bh=53jNvPUsxQBtSbRsbMy5QztIX6K5o4vByir7RxPH66U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EQ1Vi0xLZAGUMXa3LnV3sSbZN8+dBBarZAhB121BzB869eLg76uCUKFcSdJACxBC2
         FcHTQiFuavyFGzZ4XwVMogLtMK7yZJFkSOjzXplraYTh0xQk3yRGx6tnE62bUVwqpm
         vBMDXGqppQUM7Rs2s2OrqvjVgKf2t+9sTW2R5Yl850zvKjsSP1EJTmwh0Onysq/s4q
         PMkmDJFueB4b1ln/kOtl6Qk+YbebhhfI6wd7wMty63wMaErD6pdZ7oziq1m7AitiXj
         /Vg4MrYUA+jEcaF5TUh3vn5Nyh4R9TQ+O2GHdA5dRX8B7uqrUp6OKiV1ozqyAC236f
         dZoWCx1AVMPNg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E2B6840407;
        Tue, 16 May 2023 22:39:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C7A70A00C3;
        Tue, 16 May 2023 22:39:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=hjFLDYbT;
        dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D7FD7405D5;
        Tue, 16 May 2023 22:39:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoUSiYPhw9x2MvKEFNRSAlrVnY5nR/D96g6Xi9/UQ+Q1br4qINnvkZbBUj65Y6iMbN9vqC40GAVhpYaJmBfOuIvpKUrAkIOWgboOrqKbb9k759jpAOcMiE0tMaQbh+Mo2NM7+s7a54hPMRYn7Yqua1jJLWqkfEHUcast9GYcg8ccTLoRi0y20U5hSDgJxMzI1d2H3Oh8NTxEWCuu6yAvOMop1kylrOTHGeibcis0Pk36lQ8Q0K+hMpSMp5q16a/xDehciXXVXENBd9iDU4u8PIsy6ThFDJRhZ3dyyCAQ6CZiLPELNcivVRKBU4eb4x+gzYN/O5kyWJUSzLs5XmbOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53jNvPUsxQBtSbRsbMy5QztIX6K5o4vByir7RxPH66U=;
 b=iIr8lNOLXc52tawCd/aGSkAEGeMrSBXUc5ptb6e/DDF8DCOJwyMD15i24mcaIREEydK6Ge1izk5yy2KxALjdIsOWkyzFdgEsRltteZQToCCAHhWj7aejfqT9dLVXquwPfJ8N6JporQot+inbwG+xGNbTfbEG+3GRiUdKG0O6eMSUjY/6tYMpGHsCdSeF94WPx4BxzxIHmEsuFtayHbeS3Dp9R2UZVpFBTwKQu6DTOzHwWuwyttS4yrRZeIHs3kDC7oJs15RJr4Qd3zqs79adV9C082aJo8L20sJ7ueLCOtY8/GhWIZ1q6KwpqX8gxco1oRU8YPJD6N/UxdEz7S0Ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53jNvPUsxQBtSbRsbMy5QztIX6K5o4vByir7RxPH66U=;
 b=hjFLDYbT+sKQaaCYYT84n2TS4FmpGzMFjxjjg/Pw4cpIZrBXefiLpinox7R++jeGcbxzGEiSSS94pyv0nJLwYYuuNaJ6k6b6ReqYraLmqQyssFbKU8SLfNripdPUZwAc6lWgGRIdiIVbMrJPr8wwDnF8O60MUuaeMHr3F4wNywg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 22:39:22 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%5]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 22:39:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>
Subject: Re: [PATCH v8 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v8 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHZhifwmS3nkBg8RUifIdaehLDgz69b1ncAgABU9wCAAVbAgA==
Date:   Tue, 16 May 2023 22:39:21 +0000
Message-ID: <20230516223917.k4iynqopde4ltrir@synopsys.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-4-quic_kriskura@quicinc.com>
 <20230515210826.gwvmyrxrtt6yjc44@ripper>
 <d70ffe46-7282-b81e-1929-90902dd10feb@quicinc.com>
In-Reply-To: <d70ffe46-7282-b81e-1929-90902dd10feb@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA0PR12MB7462:EE_
x-ms-office365-filtering-correlation-id: 728477a2-ad4c-4b01-9b63-08db565e649f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aOQ6fcx3S3ErhMiKZyQSL1yClqHyO4DVB19XcyJHZtZ/nWh8OJ9MZ8WKoEhgwnrZPtzB/nXzpa45+fCTFFr/1B3nx1UdBG6h5qI+CCnJbVCkvhQ80z0TnxOTvSYK7mqPCGHsNrjUwKHwY3VHyJntFAyFAT4QGB/IbXpy84/5/sesHRd2htQpwltpMxdqBJQxLPcVFJllSgt5mgbC8f6Vwx/U3Ggu7q3+kUWKboRG20BU3enqB4qhyh6EzSVkUb5S9ct6GGPDKD5Cuibncz2LK17VBCuXPukTVcMdl/OSCFijke2xCwEn6HO5o1jrClj+W3Y0K7eMXsO431VVtV1l+3y35DSGwRfRJJcjyNpDUq0hrB8M+YgciiMYlHJCyr5wBBDsiW0YyZI8yNmO6Onb7j0K6dZmgSHa3AUylIJRxtO2i6F/2qeJB4BfCVNorTFJCZWUEPpOCxE5h4cLbXOHCq7I0vspGadrVk4J/oL827IlUxbaIII0pAyccrhgcXatvOMcJrIoqfOn+ING4bEow5iigH2Ce/cbHNJHbTWIsmfYNVzx0HhL5u4wDmrfesuzeCXCdrmxgZn4K/cJOOBSeYQo8H8sZt1WDOPZMceI67w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(6486002)(4326008)(66556008)(66446008)(64756008)(6916009)(66946007)(66476007)(76116006)(478600001)(86362001)(316002)(966005)(54906003)(36756003)(83380400001)(6506007)(186003)(1076003)(26005)(2616005)(6512007)(53546011)(8676002)(41300700001)(5660300002)(2906002)(7416002)(71200400001)(8936002)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDF2cmV1WkpkKzNSUllhVFhpWS9IaDMwSzVmVGVqaURiL3JCOCtmdnVIVW53?=
 =?utf-8?B?dEpJUU5EM1FoWUF6VTJWWWg2K2lnc0RMajlIeHV4Q0IzbmZSLzliSFlsNGF5?=
 =?utf-8?B?ZndwNnJtZzVNbVpsVVZYaWxCU3BTcGpvWm1hNTVQK3lqbWtEVy9maDZ2VW4y?=
 =?utf-8?B?YkY3YnF1REcrWlFKY0lqY0pzZ3VFaC9qZTdIeTZMUXc4Y04xM0xSdDFKR0sw?=
 =?utf-8?B?dVljZnFTRWpMNyswSVR3RmpwU2pZVzU2Ti9SbksyL0ZjaFVhKzh0cnhxVlA5?=
 =?utf-8?B?N0tSNUNOem1pRGlaazRZOTdnUFhrNi9vQVA1QlZmWVEvTHd3TFZIeTJ6Q04r?=
 =?utf-8?B?UGt2Tlk2ZmlPWHdmcnE1SWtRSUZZRG1EdkZQMVRKWFR4SU9nMytOQXJxTjFG?=
 =?utf-8?B?TEVyeUFKT3l5NEVxWEYxZVZwSFRiNjlXTUhtaUFwaWxXWWxKc3RHNW9qc3Q4?=
 =?utf-8?B?bElWbDlycHdPTWZWT284TzAra1MxaGZYQmo0SXFDNDlpdC9tYzlYZUVVV1A0?=
 =?utf-8?B?STVmaXViVFRxRU55L1p1ckdEdncvY0k5VzFEcjd3Q0p5SW9XRmkxaTZQbHI0?=
 =?utf-8?B?bFBrUXBLZ2Y3bEZDMktpNStmcWtHUEhJWXZoN1ppZVloNkJTQUlnU1JxUm5v?=
 =?utf-8?B?TlMrS0FsVy85ZXVSRkdIRkZsN2hjeGpRZ1UyU00vNWdFTUt2aTNtOTlwQmVP?=
 =?utf-8?B?NEtWbzZGOTM5ck1paHhiWnJ5ZnlwSzVZcCtmdmpuc2pLQXhlRDR6MVhzQzVT?=
 =?utf-8?B?Z21nNVQzaVVydlZZMTVMSUxyWTdZT2hDY3gxcFBWN3JJTUM3WHNTcWVzU1ho?=
 =?utf-8?B?cDhyVzJoNktxTEVPdVNaUi9YSjdwQjdVdERyckwwb1VqckNzT3pVVHNhd1Rj?=
 =?utf-8?B?VGwwTGoyZjVnTTZlMlgzVThiUTFKdmQ5VHJYaWNuYzdVTXh3SGFnbS9lOVNI?=
 =?utf-8?B?OHVHZk9nTmhaL04wcWFFSmZLcXdQd3JnUmFESU5qcWtiaC9wRmtZeUQxWDF0?=
 =?utf-8?B?TnJ1OHRBckNFemxrbVNta3Y2WWxtc3QxbHdYMHZaVGhENTlyZTdSTEhWdXNH?=
 =?utf-8?B?SlA4YlZxUGV3a0N5ZXI1QXpLQ2hRZmpHK2RMRnYxZDdoYTloNFUyaXd2U2lI?=
 =?utf-8?B?K21rYkx6M2V2QlVqRExFTS9UdkQ4L3BacDJjTHpZZU1uYlBZdnBNKzhKZnFq?=
 =?utf-8?B?QkxtM1oybEJaZnhOWVJuVWJ5ZFNOTlA3Y2xlWFJvWVJ2UkFGL20yZEJycVJw?=
 =?utf-8?B?ZkV2Q0pyRTJZUzhjT0dCQnJuVVJpUTN4YVdNUEtWZlE0dk9yZmwxeDk1c2dh?=
 =?utf-8?B?aGRUdG4yWFlCL01FMVljbWtJSUdZWTVhenl4STAxdlloSnhhSE92QmNFcXFH?=
 =?utf-8?B?dnpCTzMxaTZqSG9XTjg4NkNmaWVwSGc0enJSQ0pnQ1hKYVVHYjNONzBwMWJy?=
 =?utf-8?B?bU1ocW8yaitQNWcyZjdyUnI3Z3p0bFZuY1k3ek84eXJLVTFOdGhrVDUzL1Fm?=
 =?utf-8?B?dVhkV1U0YlJqNVJaZjkvZC9qWDl5V0UrYmpGMVh3SytxRUh4dHRJK3dLMFEr?=
 =?utf-8?B?RzZxWDlMblMyYjVQcXVQQWZKM1lWWUt1b1IrOXNIdzhVR0xGYnZGUHFOaVJG?=
 =?utf-8?B?V2JYTGNzU0MwUWxDcVVGd0hLTUlXOWJ2TG4yaHdYeDlTMG96WEsvUU1qWnJ2?=
 =?utf-8?B?TUdMWFI3QWx0ZmliTmQrNk90SXlwdDBCaXFRQUYrNWVrMVBNcDA1T3VlWVM5?=
 =?utf-8?B?bmIyQ2QwYk1zWW0vVDBMcFdid0cxQi9kUmk0Q0V5VjV1RENPOUsyTWJaTExN?=
 =?utf-8?B?VWd0VmVhQVpYblJkRHkxRWIxeENVYmZ4ZGRKU1I3Qm5zaHNIOEUrUEQxOVhF?=
 =?utf-8?B?cnBpKzNKOUtjTERqSlJydU9QRjd1Z1h1VzVRbGNUUkNVempaYmFUNlZXK1Zt?=
 =?utf-8?B?aklYKzU4VHJ2eFBiSThmbGhDSHUrYzRTWXVJMHpmbjNGdTdXdXhUdWZ3a0tD?=
 =?utf-8?B?alY3MGxLUzRJOGlXZHR4cHBUaG9Nank2Y2ZCZThadnFpd1JwandFWm9wWTJl?=
 =?utf-8?B?V25MUTRKVmN4WU9FMmIyMjAycHdWL1JoWTdRb2FvMkJrbFNENU5iQTFJeEFI?=
 =?utf-8?Q?sXhsyoZdTPelZywXS2DH7vQZE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3272F00D106ADD45B033C780555E8C84@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QStxc2tuZXZvK3NZM0UySWZmb0Y4QTVPM3FnZnVlUERzVkdQR3Jrdkhsa08z?=
 =?utf-8?B?dEU5UXN6RTRiQWZ1NG50c3NzN2x0cDk1YWRjUTdzVTVhR1dpbWVmd1h3M1Nj?=
 =?utf-8?B?SmFNRUVuT3hxUnllejdmQ0N4dkJlUkdXRjFGU29GQWNIU2srWktNS3h1ZlJC?=
 =?utf-8?B?eDBpQUJSajAydWhXSzBkZytJb0Vlem9ncUNabS96c0hDOWFqa3FlYktkb0FH?=
 =?utf-8?B?UFhJM3UybThjNEdMcWxPWHo5a0krQS9DSWdFTnFRL2ZuU24yOC8xeEFHL1ZP?=
 =?utf-8?B?bm9nVit0WjFVdWRBc0JhM2NhOFRqWWliMHRNVXBkTjlOZFpuTmJjUlZFY1Fs?=
 =?utf-8?B?WFB3bndrRTRHL0FaS3J5amVLUnRzenRuTmk0RDJ0dk5oQkZQTzdCaW4yU2dv?=
 =?utf-8?B?ZDlmM2pNSzZOUEtsU01PVW5MU21PRjk4UnhkMytjakVXQXhrRW1sdFRtRklS?=
 =?utf-8?B?ZzZNb0loQmlVMXhXdUdMeTlXQitWbUVMQzFoS0N6WTJZZ3FlaDJjcWovNWcw?=
 =?utf-8?B?Y0lkU1lrTG53cnZ2K2V3TFJBMVNKeXdtVmtCL2NYQWVwV2lDRXZvbWdvTWlp?=
 =?utf-8?B?VjQ0NVYyeEFObkd6azhvVlNkYmZkRFQydHNBSVVaWWFuN0I3c1F5TzljK3J0?=
 =?utf-8?B?NlFOb3VWWDZaZ0ZZNGFNQW9sYWllU2pVaVJXZE5vNUJDL0MvczJ2SVYyU1F2?=
 =?utf-8?B?TWVFQ1Z0aGVnV1FTZHk1OFU5UkljNUllUHdvSVFhNG80NTQwQ0JVdlRuV0hw?=
 =?utf-8?B?bm5VSUZxTXhRbzJnbTdEWXBMV1NQZWx1cmhQRy9ESXZueEhuNFlIOGNUWHJC?=
 =?utf-8?B?LzN3YkVzaklsK3RqV0w0aHdwSmFsdFlpejlXNDJZemJnLzl5cGwzMnNld1Jr?=
 =?utf-8?B?WDJXcmwxSlY5MjV6ZFl4Qkk1UERXbGwvS1dSWHNkc0VtQ2cxQ2MwV3BtbmxM?=
 =?utf-8?B?R0FFK1YyejJQM3hXREl5VWFyK2pHdTIwWUhocCs4RXl3YlF5QUpsakNXWkx5?=
 =?utf-8?B?elFWRm9lTHd3RzhzRXFtdG05K3RXeS85aTlKdlYyeGY3TzgzdFMyZnpZbS8r?=
 =?utf-8?B?b2dJRDNhNWxKTFJrczJyNm9hYWNkTzVTMkc3dkdPOW5BTytJeXdjWmUxN1RM?=
 =?utf-8?B?M3FqdXFMYlN2S2F0Z2pSK3BCYzRNNGorQ0NsaU0wdCt1OWV0TVJYQW1keHVZ?=
 =?utf-8?B?aHlQQjNZY0cySmZPd2F2VUM5aXBWYjFiTHNGRzdmS2NkYTg1RW01RTArcjA0?=
 =?utf-8?B?TEd4dmRvYWV4bWxoc0JreUg1NGJOYml4MUgxcWh5c1dvbzBwSW1MOVcvQ01X?=
 =?utf-8?B?L2ZvVC9uWkV4aUVrV1NtQ0t5Zy9ndzVsWmIwNmlVczVOUlhCWUY2SWdoYjVE?=
 =?utf-8?B?akxQaEMyYldGRHc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728477a2-ad4c-4b01-9b63-08db565e649f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 22:39:21.7832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWynRtrSR2sduorW7q1spb91cLYXjq9tDGRNX9UzAyKRFfkxu9elqYh1uXfZCAr1OpkGAIXAOLwPJ2z1GEqKRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
X-Proofpoint-GUID: my5QQb2SLwOUxieFu4VXza-uquZ_GAU1
X-Proofpoint-ORIG-GUID: my5QQb2SLwOUxieFu4VXza-uquZ_GAU1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305160191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXkgMTYsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNS8xNi8yMDIzIDI6MzggQU0sIEJqb3JuIEFuZGVyc3NvbiB3cm90ZToNCj4gPiBP
biBTdW4sIE1heSAxNCwgMjAyMyBhdCAxMToxOToxMUFNICswNTMwLCBLcmlzaG5hIEt1cmFwYXRp
IHdyb3RlOg0KPiA+ID4gQ3VycmVudGx5IGhvc3Qtb25seSBjYXBhYmxlIERXQzMgY29udHJvbGxl
cnMgc3VwcG9ydCBNdWx0aXBvcnQuDQo+ID4gPiBUZW1wb3JhcmlseSBtYXAgWEhDSSBhZGRyZXNz
IHNwYWNlIGZvciBob3N0LW9ubHkgY29udHJvbGxlcnMgYW5kIHBhcnNlDQo+ID4gPiBYSENJIEV4
dGVuZGVkIENhcGFiaWxpdGllcyByZWdpc3RlcnMgdG8gcmVhZCBudW1iZXIgb2YgdXNiMiBwb3J0
cyBhbmQNCj4gPiA+IHVzYjMgcG9ydHMgcHJlc2VudCBvbiBtdWx0aXBvcnQgY29udHJvbGxlci4g
RWFjaCBVU0IgUG9ydCBpcyBhdCBsZWFzdCBIUw0KPiA+ID4gY2FwYWJsZS4NCj4gPiA+IA0KPiA+
ID4gVGhlIHBvcnQgaW5mbyBmb3IgdXNiMiBhbmQgdXNiMyBwaHkgYXJlIGlkZW50aWZpZWQgYXMg
bnVtX3VzYjJfcG9ydHMNCj4gPiA+IGFuZCBudW1fdXNiM19wb3J0cy4gVGhlIGludGVudGlvbiBp
cyBhcyBmb2xsb3dzOg0KPiA+ID4gDQo+ID4gPiBXaGVyZXZlciB3ZSBuZWVkIHRvIHBlcmZvcm0g
cGh5IG9wZXJhdGlvbnMgbGlrZToNCj4gPiA+IA0KPiA+ID4gTE9PUF9PVkVSX05VTUJFUl9PRl9B
VkFJTEFCTEVfUE9SVFMoKQ0KPiA+ID4gew0KPiA+ID4gCXBoeV9zZXRfbW9kZShkd2MtPnVzYjJf
Z2VuZXJpY19waHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gPiA+IAlwaHlfc2V0X21vZGUo
ZHdjLT51c2IzX2dlbmVyaWNfcGh5W2ldLCBQSFlfTU9ERV9VU0JfSE9TVCk7DQo+ID4gPiB9DQo+
ID4gPiANCj4gPiA+IElmIG51bWJlciBvZiB1c2IyIHBvcnRzIGlzIDMsIGxvb3AgY2FuIGdvIGZy
b20gaW5kZXggMC0yIGZvcg0KPiA+ID4gdXNiMl9nZW5lcmljX3BoeS4gSWYgbnVtYmVyIG9mIHVz
YjMtcG9ydHMgaXMgMiwgd2UgZG9uJ3Qga25vdyBmb3Igc3VyZSwNCj4gPiA+IGlmIHRoZSBmaXJz
dCAyIHBvcnRzIGFyZSBTUyBjYXBhYmxlIG9yIHNvbWUgb3RoZXIgcG9ydHMgbGlrZSAoMiBhbmQg
MykNCj4gPiA+IGFyZSBTUyBjYXBhYmxlLiBTbyBpbnN0ZWFkLCBudW1fdXNiMl9wb3J0cyBpcyB1
c2VkIHRvIGxvb3AgYXJvdW5kIGFsbA0KPiA+ID4gcGh5J3MgKGJvdGggaHMgYW5kIHNzKSBmb3Ig
cGVyZm9ybWluZyBwaHkgb3BlcmF0aW9ucy4gSWYgYW55DQo+ID4gPiB1c2IzX2dlbmVyaWNfcGh5
IHR1cm5zIG91dCB0byBiZSBOVUxMLCBwaHkgb3BlcmF0aW9uIGp1c3QgYmFpbHMgb3V0Lg0KPiA+
ID4gDQo+ID4gPiBudW1fdXNiM19wb3J0cyBpcyB1c2VkIHRvIG1vZGlmeSBHVVNCM1BJUEVDVEwg
cmVnaXN0ZXJzIHdoaWxlIHNldHRpbmcgdXANCj4gPiA+IHBoeSdzIGFzIHdlIG5lZWQgdG8ga25v
dyBob3cgbWFueSBTUyBjYXBhYmxlIHBvcnRzIGFyZSB0aGVyZSBmb3IgdGhpcy4NCj4gPiA+IA0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWlj
aW5jLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDEx
MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgIGRyaXZl
cnMvdXNiL2R3YzMvY29yZS5oIHwgIDE3ICsrKysrLQ0KPiA+ID4gICAyIGZpbGVzIGNoYW5nZWQs
IDEyOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+
ID4gPiBpbmRleCAwYmVhYWI5MzJlN2QuLmU5ODNhZWYxZmI5MyAxMDA2NDQNCj4gPiA+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYw0KPiA+ID4gQEAgLTE3NjcsNiArMTc2NywxMDQgQEAgc3RhdGljIGludCBkd2MzX2dldF9j
bG9ja3Moc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ICAgCXJldHVybiAwOw0KPiA+ID4gICB9DQo+
ID4gPiArLyoqDQo+ID4gPiArICogZHdjM194aGNpX2ZpbmRfbmV4dF9leHRfY2FwIC0gRmluZCB0
aGUgb2Zmc2V0IG9mIHRoZSBleHRlbmRlZCBjYXBhYmlsaXRpZXMNCj4gPiA+ICsgKgkJCQkJd2l0
aCBjYXBhYmlsaXR5IElEIGlkLg0KPiA+IA0KPiA+ICgpIGFmdGVyIGZ1bmN0aW9uIG5hbWUgaW4g
a2VybmVsLWRvYw0KPiA+IA0KPiA+ID4gKyAqDQo+ID4gPiArICogQGJhc2U6CVBDSSBNTUlPIHJl
Z2lzdGVycyBiYXNlIGFkZHJlc3MuDQo+ID4gDQo+ID4gU2hvdWxkIHRoaXMgYmUgIlhIQ0kgTU1J
Ty4uLiI/DQo+IA0KPiBIaSBCam9ybiwNCj4gDQo+ICAgSSBjb3BpZWQgdGhpcyBjb2RlIGZyb20g
eGhjaS1leHQtY2Fwcy5oLiBUaGUgZG9jdW1lbnRhdGlvbiBvZiB0aGlzDQo+IGZ1bmN0aW9uIG1l
bnRpb25lZCBQQ0kgaW4gdGhhdCBmaWxlLiBNYXkgYmUgVGhpbmgvTWF0aGlhcyBjYW4gY29ycmVj
dCB1cyBpZg0KPiB0aGlzIGlzIHdyb25nLg0KPiANCg0KSXQncyB0aGUgYmVnaW5uaW5nIG9mIHRo
ZSB4aGNpIE1NSU8gYWRkcmVzcyBzcGFjZS4gWW91IGNhbiByZWZlciB0byBpdA0KYXMgInhIQ0kg
TU1JTyBiYXNlIGFkZHJlc3MiLiBJdCdzIG5vdCBzcGVjaWZpYyB0byBQQ0kgeEhDSS4NCg0KPiA+
IA0KPiA+ID4gKyAqIEBzdGFydDoJYWRkcmVzcyBhdCB3aGljaCB0byBzdGFydCBsb29raW5nLCAo
MCBvciBIQ0NfUEFSQU1TIHRvIHN0YXJ0IGF0DQo+ID4gPiArICoJCWJlZ2lubmluZyBvZiBsaXN0
KQ0KPiA+ID4gKyAqIEBpZDoJCUV4dGVuZGVkIGNhcGFiaWxpdHkgSUQgdG8gc2VhcmNoIGZvciwg
b3IgMCBmb3IgdGhlIG5leHQNCj4gPiA+ICsgKgkJY2FwYWJpbGl0eQ0KPiA+ID4gKyAqDQo+ID4g
PiArICogUmV0dXJucyB0aGUgb2Zmc2V0IG9mIHRoZSBuZXh0IG1hdGNoaW5nIGV4dGVuZGVkIGNh
cGFiaWxpdHkgc3RydWN0dXJlLg0KPiA+IA0KPiA+IFJldHVybjogVGhlIG9mZnNldC4uLg0KPiA+
IA0KPiA+IFBlciBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly93d3cua2VybmVs
Lm9yZy9kb2MvaHRtbC9uZXh0L2RvYy1ndWlkZS9rZXJuZWwtZG9jLmh0bWxfXzshIUE0RjJSOUdf
cGchYkV3YmxTS01jTHZSNUZBNUhFWWdWOThLUjRWd2pqOVduSUtIc1VhNXVkYnA3WU9CekxSNzdZ
ekw1SWpxeDQxa2NlNEREY2dVdFNzRm9TMVRuN2luSVBBUVpGZFZ1dyQgLg0KPiA+IA0KPiANCj4g
SSBleGVjdXRlZCB0aGUgZm9sbG93aW5nIGNvbW1hbmQgYW5kIGl0IGRpZG4ndCBnaXZlIGFueSBl
cnJvcnM6DQo+IA0KPiAuL3NjcmlwdHMva2VybmVsLWRvYyAtbm9uZSAtV2Vycm9yIC1mdW5jdGlv
biBkd2MzX3hoY2lfZmluZF9uZXh0X2V4dF9jYXANCj4gZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gDQo+IEkgc2VlIHRoYXQgZXZlbiBmb3IgZHdjM19jb3JlX2luaXQgdGhlIGNvbW1lbnRzIGFy
ZSB0aGUgc2FtZToNCj4gDQo+IC8qKg0KPiAqIGR3YzNfY29yZV9pbml0IC0gTG93LWxldmVsIGlu
aXRpYWxpemF0aW9uIG9mIERXQzMgQ29yZQ0KPiAqIEBkd2M6IFBvaW50ZXIgdG8gb3VyIGNvbnRy
b2xsZXIgY29udGV4dCBzdHJ1Y3R1cmUNCj4gKg0KPiAqIFJldHVybnMgMCBvbiBzdWNjZXNzIG90
aGVyd2lzZSBuZWdhdGl2ZSBlcnJuby4NCj4gKi8NCg0KVGhlIGRvY3VtZW50YXRpb24gQmpvcm4g
c2VudCBpcyBjb3JyZWN0LiBUaGUgc2NyaXB0IGlzbid0IHNtYXJ0IGVub3VnaA0KdG8gY2F0Y2gg
ZXZlcnl0aGluZy4gTG9va3MgbGlrZSB3ZSBoYXZlIGEgbG90IG9mIGtlcm5lbC1kb2MgbWlzdGFr
ZXMgaW4NCmR3YzMuDQoNCj4gDQo+ID4gPiArICogU29tZSBjYXBhYmlsaXRpZXMgY2FuIG9jY3Vy
IHNldmVyYWwgdGltZXMsIGUuZy4sIHRoZSBYSENJX0VYVF9DQVBTX1BST1RPQ09MLA0KPiA+ID4g
KyAqIGFuZCB0aGlzIHByb3ZpZGVzIGEgd2F5IHRvIGZpbmQgdGhlbSBhbGwuDQo+ID4gPiArICov
DQo+ID4gPiArc3RhdGljIGludCBkd2MzX3hoY2lfZmluZF9uZXh0X2V4dF9jYXAodm9pZCBfX2lv
bWVtICpiYXNlLCB1MzIgc3RhcnQsIGludCBpZCkNCj4gPiA+ICt7DQo+ID4gPiArCXUzMiB2YWw7
DQo+ID4gPiArCXUzMiBuZXh0Ow0KPiA+ID4gKwl1MzIgb2Zmc2V0Ow0KPiA+ID4gKw0KPiA+ID4g
KwlvZmZzZXQgPSBzdGFydDsNCj4gPiA+ICsJaWYgKCFzdGFydCB8fCBzdGFydCA9PSBYSENJX0hD
Q19QQVJBTVNfT0ZGU0VUKSB7DQo+ID4gPiArCQl2YWwgPSByZWFkbChiYXNlICsgWEhDSV9IQ0Nf
UEFSQU1TX09GRlNFVCk7DQo+ID4gPiArCQlpZiAodmFsID09IH4wKQ0KPiA+ID4gKwkJCXJldHVy
biAwOw0KPiA+ID4gKwkJb2Zmc2V0ID0gWEhDSV9IQ0NfRVhUX0NBUFModmFsKSA8PCAyOw0KPiA+
ID4gKwkJaWYgKCFvZmZzZXQpDQo+ID4gPiArCQkJcmV0dXJuIDA7DQo+ID4gPiArCX0NCj4gPiA+
ICsJZG8gew0KPiA+ID4gKwkJdmFsID0gcmVhZGwoYmFzZSArIG9mZnNldCk7DQo+ID4gPiArCQlp
ZiAodmFsID09IH4wKQ0KPiA+ID4gKwkJCXJldHVybiAwOw0KPiA+ID4gKwkJaWYgKG9mZnNldCAh
PSBzdGFydCAmJiAoaWQgPT0gMCB8fCBYSENJX0VYVF9DQVBTX0lEKHZhbCkgPT0gaWQpKQ0KPiA+
ID4gKwkJCXJldHVybiBvZmZzZXQ7DQo+ID4gPiArDQo+ID4gPiArCQluZXh0ID0gWEhDSV9FWFRf
Q0FQU19ORVhUKHZhbCk7DQo+ID4gPiArCQlvZmZzZXQgKz0gbmV4dCA8PCAyOw0KPiA+ID4gKwl9
IHdoaWxlIChuZXh0KTsNCj4gPiA+ICsNCj4gPiA+ICsJcmV0dXJuIDA7DQo+ID4gPiArfQ0KPiA+
ID4gKw0KPiA+ID4gK3N0YXRpYyBpbnQgZHdjM19yZWFkX3BvcnRfaW5mbyhzdHJ1Y3QgZHdjMyAq
ZHdjKQ0KPiA+ID4gK3sNCj4gPiA+ICsJdm9pZCBfX2lvbWVtCQkqcmVnczsNCj4gPiA+ICsJdTMy
CQkJb2Zmc2V0Ow0KPiA+ID4gKwl1MzIJCQl0ZW1wOw0KPiA+ID4gKwl1OAkJCW1ham9yX3Jldmlz
aW9uOw0KPiA+ID4gKwlpbnQJCQlyZXQgPSAwOw0KPiA+IA0KPiA+IFBsZWFzZSBkcm9wIHRoZSBz
cGFjaW5nIGJldHdlZW4gdHlwZSBhbmQgdmFyaWFibGUgbmFtZSBoZXJlLCBpZiBub3RoaW5nDQo+
ID4gZWxzZSBpdCdzIGluY29uc2lzdGVudCB3aXRoIHRoZSBwcmV2aW91cyBmdW5jdGlvbi4NCj4g
PiANCj4gDQo+IFN1cmUsIHdpbGwgZml4IHRoaXMgbml0Lg0KPiANCg0KSXQncyB1bmRlcnN0YW5k
YWJsZSB3aHkgeW91IGhhZCB0aGlzIGluIHRoZSBiZWdpbm5pbmcgc2luY2UgaXQncyBjb21tb24N
CmluIGRpZmZlcmVudCBwbGFjZXMgd2l0aGluIGR3YzMgZHJpdmVyLiBJdCdzIGEgYml0IGRpZmZp
Y3VsdCB0byBlbmZvcmNlDQp0aGlzLCBhbmQgaXQncyBqdXN0IG1pbm9yIHN0eWxlIGlzc3VlLiBN
eSBvbmx5IHJlcXVlc3QgaXMgdG8ga2VlcCBpdA0KY29uc2lzdGVudCB0aHJvdWdob3V0IHlvdXIg
Y2hhbmdlcy4NCg0KVGhhbmtzLA0KVGhpbmgNCg0KDQo+ID4gPiArDQo+ID4gPiArCS8qDQo+ID4g
PiArCSAqIFJlbWFwIHhIQ0kgYWRkcmVzcyBzcGFjZSB0byBhY2Nlc3MgWEhDSSBleHQgY2FwIHJl
Z3MsDQo+ID4gPiArCSAqIHNpbmNlIGl0IGlzIG5lZWRlZCB0byBnZXQgcG9ydCBpbmZvLg0KPiA+
ID4gKwkgKi8NCj4gPiA+ICsJcmVncyA9IGlvcmVtYXAoZHdjLT54aGNpX3Jlc291cmNlc1swXS5z
dGFydCwNCj4gPiA+ICsJCQkJcmVzb3VyY2Vfc2l6ZSgmZHdjLT54aGNpX3Jlc291cmNlc1swXSkp
Ow0KPiA+ID4gKwlpZiAoSVNfRVJSKHJlZ3MpKQ0KPiA+ID4gKwkJcmV0dXJuIFBUUl9FUlIocmVn
cyk7DQo+ID4gPiArDQo+ID4gPiArCW9mZnNldCA9IGR3YzNfeGhjaV9maW5kX25leHRfZXh0X2Nh
cChyZWdzLCAwLA0KPiA+ID4gKwkJCQkJWEhDSV9FWFRfQ0FQU19QUk9UT0NPTCk7DQo+ID4gPiAr
CXdoaWxlIChvZmZzZXQpIHsNCj4gPiA+ICsJCXRlbXAgPSByZWFkbChyZWdzICsgb2Zmc2V0KTsN
Cj4gPiA+ICsJCW1ham9yX3JldmlzaW9uID0gWEhDSV9FWFRfUE9SVF9NQUpPUih0ZW1wKTsNCj4g
PiA+ICsNCj4gPiA+ICsJCXRlbXAgPSByZWFkbChyZWdzICsgb2Zmc2V0ICsgMHgwOCk7DQo+ID4g
PiArCQlpZiAobWFqb3JfcmV2aXNpb24gPT0gMHgwMykgew0KPiA+ID4gKwkJCWR3Yy0+bnVtX3Vz
YjNfcG9ydHMgKz0gWEhDSV9FWFRfUE9SVF9DT1VOVCh0ZW1wKTsNCj4gPiA+ICsJCX0gZWxzZSBp
ZiAobWFqb3JfcmV2aXNpb24gPD0gMHgwMikgew0KPiA+ID4gKwkJCWR3Yy0+bnVtX3VzYjJfcG9y
dHMgKz0gWEhDSV9FWFRfUE9SVF9DT1VOVCh0ZW1wKTsNCj4gPiA+ICsJCX0gZWxzZSB7DQo+ID4g
PiArCQkJZGV2X2Vycihkd2MtPmRldiwNCj4gPiA+ICsJCQkJIlVucmVjb2duaXplZCBwb3J0IG1h
am9yIHJldmlzaW9uICVkXG4iLCBtYWpvcl9yZXZpc2lvbik7DQo+ID4gPiArCQkJcmV0ID0gLUVJ
TlZBTDsNCj4gPiA+ICsJCQlnb3RvIHVubWFwX3JlZzsNCj4gPiA+ICsJCX0NCj4gPiA+ICsNCj4g
PiA+ICsJCW9mZnNldCA9IGR3YzNfeGhjaV9maW5kX25leHRfZXh0X2NhcChyZWdzLCBvZmZzZXQs
DQo+ID4gPiArCQkJCQkJWEhDSV9FWFRfQ0FQU19QUk9UT0NPTCk7DQo+ID4gPiArCX0NCj4gPiA+
ICsNCj4gPiA+ICsJdGVtcCA9IHJlYWRsKHJlZ3MgKyBEV0MzX1hIQ0lfSENTUEFSQU1TMSk7DQo+
ID4gPiArCWlmIChIQ1NfTUFYX1BPUlRTKHRlbXApICE9IChkd2MtPm51bV91c2IzX3BvcnRzICsg
ZHdjLT5udW1fdXNiMl9wb3J0cykpIHsNCj4gPiA+ICsJCWRldl9lcnIoZHdjLT5kZXYsDQo+ID4g
PiArCQkJIk1pc21hdGNoZWQgcmVwb3J0ZWQgTUFYUE9SVFMgKCVkKVxuIiwgSENTX01BWF9QT1JU
Uyh0ZW1wKSk7DQo+ID4gPiArCQlyZXQgPSAtRUlOVkFMOw0KPiA+ID4gKwkJZ290byB1bm1hcF9y
ZWc7DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJZGV2X2RiZyhkd2MtPmRldiwNCj4gPiA+
ICsJCSJocy1wb3J0czogJWQgc3MtcG9ydHM6ICVkXG4iLCBkd2MtPm51bV91c2IyX3BvcnRzLCBk
d2MtPm51bV91c2IzX3BvcnRzKTsNCj4gPiA+ICsNCj4gPiA+ICt1bm1hcF9yZWc6DQo+ID4gPiAr
CWlvdW5tYXAocmVncyk7DQo+ID4gPiArCXJldHVybiByZXQ7DQo+ID4gPiArfQ0KPiA+ID4gKw0K
PiA+ID4gICBzdGF0aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gPiA+ICAgew0KPiA+ID4gICAJc3RydWN0IGRldmljZQkJKmRldiA9ICZwZGV2LT5kZXY7
DQo+ID4gPiBAQCAtMTc3NCw2ICsxODcyLDcgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiAgIAl2b2lkIF9faW9tZW0JCSpyZWdzOw0K
PiA+ID4gICAJc3RydWN0IGR3YzMJCSpkd2M7DQo+ID4gPiAgIAlpbnQJCQlyZXQ7DQo+ID4gPiAr
CXVuc2lnbmVkIGludAkJaHdfbW9kZTsNCj4gPiA+ICAgCWR3YyA9IGRldm1fa3phbGxvYyhkZXYs
IHNpemVvZigqZHdjKSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiAgIAlpZiAoIWR3YykNCj4gPiA+IEBA
IC0xODQzLDYgKzE5NDIsMjAgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gPiAgIAkJCWdvdG8gZXJyX2Rpc2FibGVfY2xrczsNCj4gPiA+
ICAgCX0NCj4gPiA+ICsJLyoNCj4gPiA+ICsJICogQ3VycmVudGx5IERXQzMgY29udHJvbGxlcnMg
dGhhdCBhcmUgaG9zdC1vbmx5IGNhcGFibGUNCj4gPiA+ICsJICogc3VwcG9ydCBNdWx0aXBvcnQN
Cj4gPiA+ICsJICovDQo+ID4gPiArCWh3X21vZGUgPSBEV0MzX0dIV1BBUkFNUzBfTU9ERShkd2Mt
Pmh3cGFyYW1zLmh3cGFyYW1zMCk7DQo+ID4gPiArCWlmIChod19tb2RlID09IERXQzNfR0hXUEFS
QU1TMF9NT0RFX0hPU1QpIHsNCj4gPiA+ICsJCXJldCA9IGR3YzNfcmVhZF9wb3J0X2luZm8oZHdj
KTsNCj4gPiA+ICsJCWlmIChyZXQpDQo+ID4gPiArCQkJZ290byBlcnJfZGlzYWJsZV9jbGtzOw0K
PiA+ID4gKwl9IGVsc2Ugew0KPiA+ID4gKwkJZHdjLT5udW1fdXNiMl9wb3J0cyA9IDE7DQo+ID4g
PiArCQlkd2MtPm51bV91c2IzX3BvcnRzID0gMTsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4g
ICAJc3Bpbl9sb2NrX2luaXQoJmR3Yy0+bG9jayk7DQo+ID4gPiAgIAltdXRleF9pbml0KCZkd2Mt
Pm11dGV4KTsNCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gPiBpbmRleCBkNTY0NTdjMDI5OTYuLmQzNDAxOTYz
YmMyNyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+ID4gQEAgLTM1LDYgKzM1LDE3IEBADQo+
ID4gPiAgICNkZWZpbmUgRFdDM19NU0dfTUFYCTUwMA0KPiA+ID4gKy8qIERlZmluZSBYSENJIEV4
dGNhcCByZWdpc3RlciBvZmZzZXRzIGZvciBnZXR0aW5nIG11bHRpcG9ydCBpbmZvICovDQo+ID4g
PiArI2RlZmluZSBYSENJX0hDQ19QQVJBTVNfT0ZGU0VUCTB4MTANCj4gPiA+ICsjZGVmaW5lIERX
QzNfWEhDSV9IQ1NQQVJBTVMxCTB4MDQNCj4gPiA+ICsjZGVmaW5lIFhIQ0lfRVhUX0NBUFNfUFJP
VE9DT0wJMg0KPiA+ID4gKyNkZWZpbmUgWEhDSV9IQ0NfRVhUX0NBUFMoeCkgICAgKCgoeCkgPj4g
MTYpICYgMHhmZmZmKQ0KPiA+ID4gKyNkZWZpbmUgWEhDSV9FWFRfQ0FQU19JRCh4KSAgICAgKCgo
eCkgPj4gMCkgJiAweGZmKQ0KPiA+ID4gKyNkZWZpbmUgWEhDSV9FWFRfQ0FQU19ORVhUKHgpICAg
KCgoeCkgPj4gOCkgJiAweGZmKQ0KPiA+ID4gKyNkZWZpbmUgWEhDSV9FWFRfUE9SVF9NQUpPUih4
KSAgKCgoeCkgPj4gMjQpICYgMHhmZikNCj4gPiA+ICsjZGVmaW5lIFhIQ0lfRVhUX1BPUlRfQ09V
TlQoeCkgICgoKHgpID4+IDgpICYgMHhmZikNCj4gPiA+ICsjZGVmaW5lIEhDU19NQVhfUE9SVFMo
eCkgICAgICAgICgoKHgpID4+IDI0KSAmIDB4N2YpDQo+ID4gPiArDQo+ID4gPiAgIC8qIEdsb2Jh
bCBjb25zdGFudHMgKi8NCj4gPiA+ICAgI2RlZmluZSBEV0MzX1BVTExfVVBfVElNRU9VVAk1MDAJ
LyogbXMgKi8NCj4gPiA+ICAgI2RlZmluZSBEV0MzX0JPVU5DRV9TSVpFCTEwMjQJLyogc2l6ZSBv
ZiBhIHN1cGVyc3BlZWQgYnVsayAqLw0KPiA+ID4gQEAgLTEwMjUsNiArMTAzNiw4IEBAIHN0cnVj
dCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0KPiA+ID4gICAgKiBAdXNiX3BzeTogcG9pbnRlciB0
byBwb3dlciBzdXBwbHkgaW50ZXJmYWNlLg0KPiA+ID4gICAgKiBAdXNiMl9waHk6IHBvaW50ZXIg
dG8gVVNCMiBQSFkNCj4gPiA+ICAgICogQHVzYjNfcGh5OiBwb2ludGVyIHRvIFVTQjMgUEhZDQo+
ID4gPiArICogQG51bV91c2IyX3BvcnRzOiBudW1iZXIgb2YgdXNiMiBwb3J0cy4NCj4gPiA+ICsg
KiBAbnVtX3VzYjNfcG9ydHM6IG51bWJlciBvZiB1c2IzIHBvcnRzLg0KPiA+ID4gICAgKiBAdXNi
Ml9nZW5lcmljX3BoeTogcG9pbnRlciB0byBVU0IyIFBIWQ0KPiA+ID4gICAgKiBAdXNiM19nZW5l
cmljX3BoeTogcG9pbnRlciB0byBVU0IzIFBIWQ0KPiA+ID4gICAgKiBAcGh5c19yZWFkeTogZmxh
ZyB0byBpbmRpY2F0ZSB0aGF0IFBIWXMgYXJlIHJlYWR5DQo+ID4gPiBAQCAtMTE2Miw2ICsxMTc1
LDkgQEAgc3RydWN0IGR3YzMgew0KPiA+ID4gICAJc3RydWN0IHVzYl9waHkJCSp1c2IyX3BoeTsN
Cj4gPiA+ICAgCXN0cnVjdCB1c2JfcGh5CQkqdXNiM19waHk7DQo+ID4gPiArCXU4CQkJbnVtX3Vz
YjJfcG9ydHM7DQo+ID4gPiArCXU4CQkJbnVtX3VzYjNfcG9ydHM7DQo+ID4gPiArDQo+ID4gPiAg
IAlzdHJ1Y3QgcGh5CQkqdXNiMl9nZW5lcmljX3BoeTsNCj4gPiA+ICAgCXN0cnVjdCBwaHkJCSp1
c2IzX2dlbmVyaWNfcGh5Ow0KPiA+ID4gQEAgLTE2NDksNSArMTY2NSw0IEBAIHN0YXRpYyBpbmxp
bmUgaW50IGR3YzNfdWxwaV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiAgIHN0YXRpYyBp
bmxpbmUgdm9pZCBkd2MzX3VscGlfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gICB7IH0N
Cj4gPiA+ICAgI2VuZGlmDQo+ID4gPiAtDQo+ID4gPiAgICNlbmRpZiAvKiBfX0RSSVZFUlNfVVNC
X0RXQzNfQ09SRV9IICovDQo+ID4gPiAtLSANCj4gPiA+IDIuNDAuMA0KPiA+ID4g
