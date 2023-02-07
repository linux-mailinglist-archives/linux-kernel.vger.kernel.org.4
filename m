Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DBE68CB19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 01:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBGAZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 19:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBGAZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 19:25:56 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A9834018;
        Mon,  6 Feb 2023 16:25:20 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316NAbI4026904;
        Mon, 6 Feb 2023 16:25:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=B9o+uQXqQ1Vo7g1kjnZUB0IX47hdg2Dn2Nmh5mfGr8Y=;
 b=jAiMbdnYEY8xBH64SL98Ee8a3N62WkCwq0CNYXV5b9DY0Y74XxlLlW2PT/epYdm8PG9f
 Ts62xUROoflxObwH0cPRw2DlE72qAY9UDYwvjtIFeDw2PYm5UVYFqNop56QABumeiXoj
 dmctP7S2bPY+oar8lRii3ko51S8OVZgM3r6oWNC435uHcyJ9p8esdQ4tsiSRHoR2tyvx
 kocrIWzou/c1PvSZRFUB22kgZKt81BtgkphCSlefS7APzG4UGrbv26xLS7GE2EDIEZm3
 05ckiyL9HQOzG3TboKRi6IUvbghVz9W7wmRlSfD3cdtVQMV3HnOAsylLSJ7obhj6eEDg Qg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3nhpvmk21t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 16:25:02 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7981A400AF;
        Tue,  7 Feb 2023 00:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1675729501; bh=B9o+uQXqQ1Vo7g1kjnZUB0IX47hdg2Dn2Nmh5mfGr8Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=R3Gte/qwCpNev3ptoFqRr/WK7hkFVQmOxmtcFxkUD7JksAYffDRQnAFQBkU5X9A0V
         zNuDnX+1X8TMv5jRPxuh1KM89FYjRaTbX6HMXO6EyzTTcda2gBvqVIPuJYMXI9dmBx
         atL7F14x9i4i8kDg8YVhtXJna6q32p5HTN54Fu933bjrD+W569F7PNIY6gbn87S9K5
         vUk+JVN9BHl9VfO8b1yhW0NHwPBYHMWNIYWXE/Y8KtQgWSJBErEuUgp8WxlKP8UyF2
         TSOlceliPXi8YzFcOfEKLbVEjfdCV3MJyPBfDMRN+FoYOSIAZDIw+Mwsaohf/Zb1Uy
         bEuPOv2ccG+hg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id AD277A006F;
        Tue,  7 Feb 2023 00:25:00 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9DC3A800AA;
        Tue,  7 Feb 2023 00:24:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="o/rScHqK";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv7vEJIJ4j747Gc/qNymYMC1K2kzUD34LKA59TQrfErX31JkE0iePw638XHcmCMzsWNZBzMqKLMXHZtBCCxTliPYmcuVmHd4iYA7GyVX10ZXzw0kBuoMTycC08KSgsmv3IE1XGnMm9oh53E3nRf0kuTx68XO98ox9NemxUjU+41OFAzSA0b/59TN2I3HWhVTANbrkQYTtWICn4UFE3xpzRYUXUs22nGtOze4UEpkmswABpnKxA8SDmVR7DLxeSyZdxguWiXz394BgPdMXz3S3zzwpO4PycyMyz9ZfUlXcQA1s9iBmPp4W4jHdKUWxSejUWYMRDcuuy7V0fncvf9Viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9o+uQXqQ1Vo7g1kjnZUB0IX47hdg2Dn2Nmh5mfGr8Y=;
 b=NW0RsVkZTQ1BmPF1MI8/IksnpKQru11/n9suTpcp34uJQ6skq5aYXhrzYvvXaRGPbbmtX9ZPikhBort8sxbUb0SB6G4yRZuXE3kJioXh0XlaWnAF6K+EAyPsphnuwrCT8bKGwmb/6jgGBkrvnLey3G8m/wzDs5JQ2mEKPKdYsTTWrbLwAOExHjp64MCZn9IDQ91Ls5smXjdVWDnEjoQ2WChca5tFjsw1GASIbk5R+U9YE0kOl/qeQMVmj+G1I1vZX5NCZKAvBYfk+QOhWGCV96TdqorPthDZT5O31a+fGaybhAoNw/GTEgXJv4wJhuqOh0+ItbbeAx7UQLRbqpmO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9o+uQXqQ1Vo7g1kjnZUB0IX47hdg2Dn2Nmh5mfGr8Y=;
 b=o/rScHqK2ex9mB/jSckxTyMqJvG7vdH5BhXksmh0QOeu+2GGZvfEL1ekaEo7UT+xTpWOd4a03dQICJGXfF4kJXinS8YS12tibVAy5MRrwtyEcyNXsV847eAMJ2x8jZ3uCwYn+hjHGtum5XNj0R7Ke0/Lg7HNNAKcB32Y4442CUg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 00:24:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6064.029; Tue, 7 Feb 2023
 00:24:56 +0000
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
Subject: Re: [PATCH v3 1/5] usb: gadget: Properly configure the device for
 remote wakeup
Thread-Topic: [PATCH v3 1/5] usb: gadget: Properly configure the device for
 remote wakeup
Thread-Index: AQHZOl8iQgK6RJl9Zka5QOKz+f/2wq7CoGyA
Date:   Tue, 7 Feb 2023 00:24:56 +0000
Message-ID: <20230207002447.nh6hppnr4vawichj@synopsys.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-2-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1675710806-9735-2-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BN9PR12MB5306:EE_
x-ms-office365-filtering-correlation-id: 22922497-4c62-4851-fa40-08db08a1bd60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ZiEh9ZRp+MSTVUBS3/W7McQT06CbqH4diXVWRLiCt3cortMNqHf5jC4YCM+XpgpGw+yLpgnKfaUDr4WtZh1jdpoHITO/ZyJWvcehnHqJWxYWE/0vqAGm8IUrdjOLJwHotAgqePxyRlFZYygbaNATxlNJcQUf4TvdkjtjS5cDpYyHGW/ZQwDVmttHFLogbATwXjMYH0IelN/y91p/pkmQjmmS/wVkSZ2YhqqzvvnJcO9IThUHP+PnsyQDjx2qESVIQou3AaFvcIkROmw/on3w/TYKz+Nd82gX+45nGzIbp2l5TrBUIs0ZXkwOCbmnsV1Zap2pOdaSaJZq1jJcgWkEQMc/YY9+VMYl5zvR0wUZLQGi6d9dC4sqCaoQ58pQmwy8yYVOnk4AB+Io2O9IIBoo5mdrr2QsdFvaKuh6+zuiQ8vz3tUEz8unkfgEBxr/R3cNwqIO667GWULsFdptC4RGdrhF7VE/lH4NRDO3EPehLW3AVeqvJGDq7gluPYBTUus6wQ18McvaSqcsDaQMhCojSpeBPNZQXFjv9bNlhpRg7dVRjR/6HDLJOJG9sVuvN+S0DCZShFk8N8BV1m8Dj7F3btxDDC4SB7t3k1JWAjvFtImVM1Hxk5pB4B3eDsJTO+j0TKaCmn9fYmb5rviX7UCqUdjNAXFQw9lTFtir7Xv4aWvcEWx0VnTo3lbhvQ8m6j2aU/AfdFC1Tz5RxKmd6MZNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(36756003)(54906003)(316002)(71200400001)(6506007)(1076003)(6486002)(8676002)(66476007)(5660300002)(66556008)(64756008)(66446008)(2906002)(41300700001)(66946007)(6916009)(8936002)(76116006)(4326008)(478600001)(26005)(38100700002)(38070700005)(122000001)(86362001)(6512007)(83380400001)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHAzLy9kZHE4NEdTQVdoZVZyQmhBRE8xaFozQmF0Z0RaMWVpcUVMakNwQVlG?=
 =?utf-8?B?TFRzRk00NVlXcTF2SWR2VXUyQ0lESlptdE5SY2hQTGRuVEtDWnVrMXBMQ2NI?=
 =?utf-8?B?ZkNsSitSTHVvWWJXS0d1dExXWWNlZEdJVnFVMHY3NnNHOWRaamRSZnBQL205?=
 =?utf-8?B?V2RoMG94UXE3Q3YweTh5aE51NGRqMnJPVmNxSzNqNk5SSWVRV0V3MGZVV09J?=
 =?utf-8?B?OUV3OFpCMHFYTkdRRkNFMEFQcXd2bXdUaUhPbVdWMWJBekRCSG9iUmJ0eGxM?=
 =?utf-8?B?dXZmN2llMXVmbFVJQ2hDdjdDR2FCaDg2MnIzQ0w5UWpjZXBtc0szckFMb3F6?=
 =?utf-8?B?dXZNdkNiTnVqVWtXLzJjQnRJVzUzMXpVajA4RlorS3NOYUtUY0p0a3NNK2I3?=
 =?utf-8?B?TXh6ZlMwdytZbk1VTUxDZEhNcjFrLyt6dStHbFB4R2J0cVZyM2NsbFNKZTBy?=
 =?utf-8?B?VGgySmxKUk96enZZam5KbWM5a1VRakFYRE5weGVvU1dqK0FRRko1UHFBR2JP?=
 =?utf-8?B?QWsxSlQrV2YwTmpDUnRnYjNLR2EwQ2drdEQ1QndPZjNBL2ovQXBtU2hGemNn?=
 =?utf-8?B?QTRtM08rM1d3Y0dEMDFqdkFOak5OZ2VKbjRZd0tpTUFicHdmOS9La1lwU1BI?=
 =?utf-8?B?VjdCYkJGMGcyZ1ZEeUIxSHF3ZmxjTTFiZUcrVWx5NjNaRE4vdzJIMVJRUHRJ?=
 =?utf-8?B?M213NTF0VTdORU5YL2lrc091dU9mSjI5SlBrWS90aVVBaWpJSkNWN0VpS0Va?=
 =?utf-8?B?cW5zemFDRHNWTDFEc291UzVadkhZa2R5dEh3bWxYbUVWSTZxVHBEdHBGVnlK?=
 =?utf-8?B?dC9oalRFaUdIaWpQRjNnS0p3ODVlN3BLam52emJUVmRiTHdlK3VRa0loY01F?=
 =?utf-8?B?NE9aV2RoWVlwdTJiQUFUdkpIZ05JVHVyc1U1ZUw0bmVZcnpDQjd5MDZubC82?=
 =?utf-8?B?MWRSYWt5cEdxVCtyYVpTT01jNEJEdGFOWlYwU1FhODhOTGtoZ1hlMStjd3VS?=
 =?utf-8?B?RktLYklza1JzRGRtd29CU1hDOHJ6THBwRlRHbU5nM3lCU1ZEMlM5TmptY1ow?=
 =?utf-8?B?UGJSZHVWaXE4MEJ2M0Z2cGZoRkUybVIveGhOZjhVVzBZL2x3N2VmSEFNZ0FB?=
 =?utf-8?B?WWFsU2NUenBkTXJWSExzRklZTXAwaUQ2TXRXVHRQMk4vV283L1ZmL2diSjYr?=
 =?utf-8?B?Q3YxUnQzd29LcXpKdDNhaStxblZCRElkNGV2ejc1aG5Wb0ZmN01RTENkb25x?=
 =?utf-8?B?bHlYendaWWdMTkxlMzIwMjFYOFp1MEh1UE1kZTFVbTZxMkRYZE1pRTNUblEz?=
 =?utf-8?B?Znp1c21TSXdoR0tiSmRqZEV1bUx6Vm9jRk1sbkFtOHRJeEwvTitxNks1V3Vx?=
 =?utf-8?B?YjRvSWtxK055cEUzZHdLY3QyTjBlcG1KSFFaZkNiNmNzbzl3R3llQ2dLVTZH?=
 =?utf-8?B?YUtiemNBcFduazNpaUhtSUdWd0w0SWR1OTREUjdLWWVUNitIYzF1N05XN25E?=
 =?utf-8?B?OXZweDE2T0JvYng2ai9XT2FCVE5XMkV2ZFE1eXU2QVVRZURyWHFGSndTNGc2?=
 =?utf-8?B?MmxhWStaMWdQVjdsakpnanppay92REljcVB4R0kraGNuSTJ0eDJwaHdmV3hv?=
 =?utf-8?B?ZHBteHZuc3RXRERmRzRIV0ZlYmZjRDBGdVZBOG1PaktXS0dLV2ZiaWhzL0ZD?=
 =?utf-8?B?Tk0vY2ZQL0VNTlhTNElpem9oRlRFU0pTR1NwYWN4MUt0MUNTRlJuVEhydytC?=
 =?utf-8?B?bk5FVDdrZVhQNUhxc1VsTE5ZelhUZFkrRFdVL2xDR2dNaVV2dGlSWC9TZDkw?=
 =?utf-8?B?dUZwaVVCTGIyZnN3U3cxOFZabmdNVVJMdHN5V3ZVbS9Ldm80bmlOa1hDblhm?=
 =?utf-8?B?OUhoK3llSkNQWTk0a3g2UFhFZ08zUFBwdUpPZjE2ZjFUMmx6N3kzR1RaajBw?=
 =?utf-8?B?ZVRwOE9OSEhnVXJlVVJodEhMNysrdTZGRFVqbVBFYXlzM1R5YmdNN3ZPL2lW?=
 =?utf-8?B?NjRoZ1lrYXZTUHJPcS9UazVCcWFjM0dhU0RIY3B1eEhhWEE3cmtraWtpeWd0?=
 =?utf-8?B?UGJHekpHNlRIZGI5aG9KQWNvMkJtS3d1QTVRNk04NjZ6U25FaGJNbzhhcDBm?=
 =?utf-8?B?SngrK0ZDTDd0MVV0b2t0SWduQW9JRFUyMDRZWjlORHcyWDI3TnBCNldIbXMr?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6ADEA81948679428C774CD5FFC4906B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FIeIb6wEhhVW7W9RnpvRfoOLzmFrhAdmXB+PldeP/LSUQc0LVZnFCXS0tPoLuERnBs9YYz403ZdfuAM7c/faFRgRyNoWeXrYeLZsM1gMli+nYSFh0gNhxuAlWpj3V10DXlwsiZ/qgLlnQJO+qkO5grk839LUeNJVUCSTDPhQxGWmy28OlWxKNqgMnVASNP1D28aTzWpHSP5I5dAEiOvYFQluUKbUjYiWLpQQtMVQH97xqDnWC8+TmptSsmfGNDS/HFfUag+XU6atXINlFhqAWaOlScuQ6cG4sv5mddye2WJbMJs29gd2meb2ptRKZ86//H8bxraXCyf28ji8gApFNO+NxLXWeGVZ3rGE6o3QHUupxSiFlgLY6U0B9Irn2CrB1hlND5swdPY7Q9PDQfGf6os23pjA8u1J+7ZzQ6b4T4VJwzk2MCJS4P0TP16YjKSyjL2QxZ1OGxKJ3ZKAZKXkERhvp1PWgY09HbPCSysSuD8K9LfioZJaheF4yCYrNi6fjfAaSgnwmralV12grsAgKLrz6WgksKaBjBW8Ck0gDwO1nLNQj95ywUr16jl/iogiaAFdYEJ5yKkVOvS34gigjdGJcIW+bZoOuILx9fOXAybCi24vTn6xDDxOP/Zc0uyodHdJB6Sc52GUvuINw0z0IN5NjWA24Jur1bz9JAQGHS1M0F+res6rxIdLyVOMmNJ3RWk7c/MHekqqKGNVhRlyCc9LNbbLxDhR0ElD0vcqElgc3JQyliLzkkHChGVcB2N3DVL1M2htu9JVl7PIp8rHyjEigqnnbZ9pp/fXHoEUfkE9N5mFZHT/120H25HPjmmnlOQR4Y7g8smKpa1/NfsE2ukFUc68ZKm15GGvlcmNEDocB0cGu2V/7IyJgMcuNgCROqMiefF7si95cKbF9YBCT4xUnnq6kAR67rGWS024AOM=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22922497-4c62-4851-fa40-08db08a1bd60
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 00:24:56.2594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44Vbmr9bFl00M9DRXC64glm9tulb6Vb3p6pwJR7UAC0uWG9Gf1WV4Pzt8JdveihDhVUujJaAAn0Z9GKCZaCyhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
X-Proofpoint-ORIG-GUID: s7_cmq26zus84vTaFDDiY4eK_ef6FRja
X-Proofpoint-GUID: s7_cmq26zus84vTaFDDiY4eK_ef6FRja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=944 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRWxzb24sDQoNCk9uIE1vbiwgRmViIDA2LCAyMDIzLCBFbHNvbiBSb3kgU2VycmFvIHdyb3Rl
Og0KPiBUaGUgd2FrZXVwIGJpdCBpbiB0aGUgYm1BdHRyaWJ1dGVzIGZpZWxkIGluZGljYXRlcyB3
aGV0aGVyIHRoZSBkZXZpY2UNCj4gaXMgY29uZmlndXJlZCBmb3IgcmVtb3RlIHdha2V1cC4gQnV0
IHRoaXMgZmllbGQgc2hvdWxkIGJlIGFsbG93ZWQgdG8NCj4gc2V0IG9ubHkgaWYgdGhlIFVEQyBz
dXBwb3J0cyBzdWNoIHdha2V1cCBtZWNoYW5pc20uIFNvIGNvbmZpZ3VyZSB0aGlzDQo+IGZpZWxk
IGJhc2VkIG9uIFVEQyBjYXBhYmlsaXR5LiBBbHNvIGluZm9ybSB0aGUgVURDIHdoZXRoZXIgdGhl
IGRldmljZQ0KPiBpcyBjb25maWd1cmVkIGZvciByZW1vdGUgd2FrZXVwIGJ5IGltcGxlbWVudGlu
ZyBhIGdhZGdldCBvcC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8gPHF1
aWNfZXNlcnJhb0BxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvY29t
cG9zaXRlLmMgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIGRyaXZlcnMvdXNiL2dh
ZGdldC91ZGMvY29yZS5jICB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy90cmFjZS5oIHwgIDUgKysrKysNCj4gIGluY2x1ZGUvbGludXgv
dXNiL2dhZGdldC5oICAgICB8ICA4ICsrKysrKysrDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDYzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9nYWRnZXQvY29tcG9zaXRlLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMNCj4g
aW5kZXggZmE3ZGQ2Yy4uZTQ1OWZiMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0
L2NvbXBvc2l0ZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiBA
QCAtNTEzLDYgKzUxMywxOSBAQCBzdGF0aWMgdTggZW5jb2RlX2JNYXhQb3dlcihlbnVtIHVzYl9k
ZXZpY2Vfc3BlZWQgc3BlZWQsDQo+ICAJCXJldHVybiBtaW4odmFsLCA5MDBVKSAvIDg7DQo+ICB9
DQo+ICANCj4gK3N0YXRpYyB2b2lkIGNoZWNrX3JlbW90ZV93YWtldXBfY29uZmlnKHN0cnVjdCB1
c2JfZ2FkZ2V0ICpnYWRnZXQsDQo+ICsJCQkJICAgICAgIHN0cnVjdCB1c2JfY29uZmlndXJhdGlv
biAqYykNCj4gK3sNCj4gKwlpZiAoVVNCX0NPTkZJR19BVFRfV0FLRVVQICYgYy0+Ym1BdHRyaWJ1
dGVzKSB7DQo+ICsJCS8qIFJlc2V0IHRoZSBydyBiaXQgaWYgZ2FkZ2V0IGlzIG5vdCBjYXBhYmxl
IG9mIGl0ICovDQo+ICsJCWlmICghZ2FkZ2V0LT5yd19jYXBhYmxlKSB7DQoNClByb2JhYmx5IGl0
J3MgYmV0dGVyIHRvIG1ha2Ugc3VyZSB3ZSBkb24ndCBicmVhayB0aGUgY29uZmlndXJhdGlvbiBm
b3INCm90aGVyIFVEQ3MgdW50aWwgdGhpcyBpcyBpbXBsZW1lbnRlZCBpbiB0aGVpciBkcml2ZXJz
LiBMZXQncyBhZGQgYW5vdGhlcg0KY29uZGl0aW9uOg0KDQoJaWYgKCFnYWRnZXQtPnJ3X2NhcGFi
bGUgJiYgZ2FkZ2V0LT5vcHMtPnNldF9yZW1vdGV3YWtldXApIHsNCgkJLi4uDQoJfQ0KDQo+ICsJ
CQlJTkZPKGMtPmNkZXYsICJDbGVhcmluZyBydyBiaXQgZm9yIGNvbmZpZyBjLiVkXG4iLA0KPiAr
CQkJICAgICBjLT5iQ29uZmlndXJhdGlvblZhbHVlKTsNCg0KUGVyaGFwcyBhIHdhcm5pbmcgaXMg
YmV0dGVyIHNpbmNlIHdlJ3JlIG92ZXJ3cml0aW5nIHRoZSB1c2VyJ3MNCmNvbmZpZ3VyYXRpb24u
DQoNCj4gKwkJCWMtPmJtQXR0cmlidXRlcyAmPSB+VVNCX0NPTkZJR19BVFRfV0FLRVVQOw0KPiAr
CQl9DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IGNvbmZpZ19idWYoc3RydWN0IHVz
Yl9jb25maWd1cmF0aW9uICpjb25maWcsDQo+ICAJCWVudW0gdXNiX2RldmljZV9zcGVlZCBzcGVl
ZCwgdm9pZCAqYnVmLCB1OCB0eXBlKQ0KPiAgew0KPiBAQCAtNjIwLDggKzYzMywxMiBAQCBzdGF0
aWMgaW50IGNvbmZpZ19kZXNjKHN0cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiwgdW5zaWdu
ZWQgd192YWx1ZSkNCj4gIAkJCQljb250aW51ZTsNCj4gIAkJfQ0KPiAgDQo+IC0JCWlmICh3X3Zh
bHVlID09IDApDQo+ICsJCWlmICh3X3ZhbHVlID09IDApIHsNCj4gKwkJCS8qIENvcnJlY3RseSBj
b25maWd1cmUgdGhlIGJtQXR0cmlidXRlcyB3YWtldXAgYml0ICovDQo+ICsJCQljaGVja19yZW1v
dGVfd2FrZXVwX2NvbmZpZyhnYWRnZXQsIGMpOw0KDQpDaGVja2luZyBoZXJlIGlzIHRvbyBsYXRl
LiBXZSBzaG91bGQgY2hlY2sgaW4gY29uZmlnZnNfY29tcG9zaXRlX2JpbmQoKS4NCg0KPiArDQo+
ICAJCQlyZXR1cm4gY29uZmlnX2J1ZihjLCBzcGVlZCwgY2Rldi0+cmVxLT5idWYsIHR5cGUpOw0K
PiArCQl9DQo+ICAJCXdfdmFsdWUtLTsNCj4gIAl9DQo+ICAJcmV0dXJuIC1FSU5WQUw7DQo+IEBA
IC0xMDAwLDYgKzEwMTcsMTEgQEAgc3RhdGljIGludCBzZXRfY29uZmlnKHN0cnVjdCB1c2JfY29t
cG9zaXRlX2RldiAqY2RldiwNCj4gIAllbHNlDQo+ICAJCXVzYl9nYWRnZXRfY2xlYXJfc2VsZnBv
d2VyZWQoZ2FkZ2V0KTsNCj4gIA0KPiArCWlmIChVU0JfQ09ORklHX0FUVF9XQUtFVVAgJiBjLT5i
bUF0dHJpYnV0ZXMpDQo+ICsJCXVzYl9nYWRnZXRfc2V0X3JlbW90ZXdha2V1cChnYWRnZXQsIDEp
Ow0KPiArCWVsc2UNCj4gKwkJdXNiX2dhZGdldF9zZXRfcmVtb3Rld2FrZXVwKGdhZGdldCwgMCk7
DQo+ICsNCj4gIAl1c2JfZ2FkZ2V0X3ZidXNfZHJhdyhnYWRnZXQsIHBvd2VyKTsNCj4gIAlpZiAo
cmVzdWx0ID49IDAgJiYgY2Rldi0+ZGVsYXllZF9zdGF0dXMpDQo+ICAJCXJlc3VsdCA9IFVTQl9H
QURHRVRfREVMQVlFRF9TVEFUVVM7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvY29yZS5jDQo+IGluZGV4IDIzYjA2
MjkuLjU4NzRkNGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvY29yZS5j
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvY29yZS5jDQo+IEBAIC01MTQsNiArNTE0
LDMzIEBAIGludCB1c2JfZ2FkZ2V0X3dha2V1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KQ0K
PiAgRVhQT1JUX1NZTUJPTF9HUEwodXNiX2dhZGdldF93YWtldXApOw0KPiAgDQo+ICAvKioNCj4g
KyAqIHVzYl9nYWRnZXRfc2V0X3JlbW90ZXdha2V1cCAtIGNvbmZpZ3VyZXMgdGhlIGRldmljZSBy
ZW1vdGUgd2FrZXVwIGZlYXR1cmUuDQo+ICsgKiBAZ2FkZ2V0OnRoZSBkZXZpY2UgYmVpbmcgY29u
ZmlndXJlZCBmb3IgcmVtb3RlIHdha2V1cA0KPiArICogQHNldDp2YWx1ZSB0byBiZSBjb25maWd1
cmVkLg0KPiArICoNCj4gKyAqIHNldCB0byBvbmUgdG8gZW5hYmxlIHJlbW90ZSB3YWtldXAgZmVh
dHVyZSBhbmQgemVybyB0byBkaXNhYmxlIGl0Lg0KPiArICoNCj4gKyAqIHJldHVybnMgemVybyBv
biBzdWNjZXNzLCBlbHNlIG5lZ2F0aXZlIGVycm5vLg0KPiArICovDQo+ICtpbnQgdXNiX2dhZGdl
dF9zZXRfcmVtb3Rld2FrZXVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQsIGludCBzZXQpDQo+
ICt7DQo+ICsJaW50IHJldCA9IDA7DQo+ICsNCj4gKwlpZiAoIWdhZGdldC0+b3BzLT5zZXRfcmVt
b3Rld2FrZXVwKSB7DQo+ICsJCXJldCA9IC1FT1BOT1RTVVBQOw0KPiArCQlnb3RvIG91dDsNCj4g
Kwl9DQo+ICsNCj4gKwlyZXQgPSBnYWRnZXQtPm9wcy0+c2V0X3JlbW90ZXdha2V1cChnYWRnZXQs
IHNldCk7DQo+ICsNCj4gK291dDoNCj4gKwl0cmFjZV91c2JfZ2FkZ2V0X3NldF9yZW1vdGV3YWtl
dXAoZ2FkZ2V0LCByZXQpOw0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gK0VYUE9SVF9T
WU1CT0xfR1BMKHVzYl9nYWRnZXRfc2V0X3JlbW90ZXdha2V1cCk7DQo+ICsNCj4gKy8qKg0KPiAg
ICogdXNiX2dhZGdldF9zZXRfc2VsZnBvd2VyZWQgLSBzZXRzIHRoZSBkZXZpY2Ugc2VsZnBvd2Vy
ZWQgZmVhdHVyZS4NCj4gICAqIEBnYWRnZXQ6dGhlIGRldmljZSBiZWluZyBkZWNsYXJlZCBhcyBz
ZWxmLXBvd2VyZWQNCj4gICAqDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L3RyYWNlLmggYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL3RyYWNlLmgNCj4gaW5kZXggYWJkYmNi
MS4uYTMzMTRjZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy90cmFjZS5o
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvdHJhY2UuaA0KPiBAQCAtOTEsNiArOTEs
MTEgQEAgREVGSU5FX0VWRU5UKHVkY19sb2dfZ2FkZ2V0LCB1c2JfZ2FkZ2V0X3dha2V1cCwNCj4g
IAlUUF9BUkdTKGcsIHJldCkNCj4gICk7DQo+ICANCj4gK0RFRklORV9FVkVOVCh1ZGNfbG9nX2dh
ZGdldCwgdXNiX2dhZGdldF9zZXRfcmVtb3Rld2FrZXVwLA0KPiArCVRQX1BST1RPKHN0cnVjdCB1
c2JfZ2FkZ2V0ICpnLCBpbnQgcmV0KSwNCj4gKwlUUF9BUkdTKGcsIHJldCkNCj4gKyk7DQo+ICsN
Cj4gIERFRklORV9FVkVOVCh1ZGNfbG9nX2dhZGdldCwgdXNiX2dhZGdldF9zZXRfc2VsZnBvd2Vy
ZWQsDQo+ICAJVFBfUFJPVE8oc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCByZXQpLA0KPiAgCVRQ
X0FSR1MoZywgcmV0KQ0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC91c2IvZ2FkZ2V0Lmgg
Yi9pbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaA0KPiBpbmRleCBkYzMwOTJjLi4wNWQxNDQ5IDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaA0KPiArKysgYi9pbmNsdWRl
L2xpbnV4L3VzYi9nYWRnZXQuaA0KPiBAQCAtMzA5LDYgKzMwOSw3IEBAIHN0cnVjdCB1c2JfdWRj
Ow0KPiAgc3RydWN0IHVzYl9nYWRnZXRfb3BzIHsNCj4gIAlpbnQJKCpnZXRfZnJhbWUpKHN0cnVj
dCB1c2JfZ2FkZ2V0ICopOw0KPiAgCWludAkoKndha2V1cCkoc3RydWN0IHVzYl9nYWRnZXQgKik7
DQo+ICsJaW50CSgqc2V0X3JlbW90ZXdha2V1cCkoc3RydWN0IHVzYl9nYWRnZXQgKiwgaW50IHNl
dCk7DQoNCm1pbm9yIG5pdDogY2FuIHdlIGNoYW5nZSB0aGlzIG5hbWUgdG8gc2V0X3JlbW90ZV93
YWtldXAuIEl0J3MgYSBiaXQNCmVhc2llciB0byByZWFkIElNTy4NCg0KPiAgCWludAkoKnNldF9z
ZWxmcG93ZXJlZCkgKHN0cnVjdCB1c2JfZ2FkZ2V0ICosIGludCBpc19zZWxmcG93ZXJlZCk7DQo+
ICAJaW50CSgqdmJ1c19zZXNzaW9uKSAoc3RydWN0IHVzYl9nYWRnZXQgKiwgaW50IGlzX2FjdGl2
ZSk7DQo+ICAJaW50CSgqdmJ1c19kcmF3KSAoc3RydWN0IHVzYl9nYWRnZXQgKiwgdW5zaWduZWQg
bUEpOw0KPiBAQCAtMzgzLDYgKzM4NCw4IEBAIHN0cnVjdCB1c2JfZ2FkZ2V0X29wcyB7DQo+ICAg
KiBAY29ubmVjdGVkOiBUcnVlIGlmIGdhZGdldCBpcyBjb25uZWN0ZWQuDQo+ICAgKiBAbHBtX2Nh
cGFibGU6IElmIHRoZSBnYWRnZXQgbWF4X3NwZWVkIGlzIEZVTEwgb3IgSElHSCwgdGhpcyBmbGFn
DQo+ICAgKglpbmRpY2F0ZXMgdGhhdCBpdCBzdXBwb3J0cyBMUE0gYXMgcGVyIHRoZSBMUE0gRUNO
ICYgZXJyYXRhLg0KPiArICogQHJ3X2NhcGFibGU6IFRydWUgaWYgZ2FkZ2V0IGlzIGNhcGFibGUg
b2Ygc2VuZGluZyByZW1vdGUgd2FrZXVwLg0KPiArICogQHJ3X2FybWVkOiBUcnVlIGlmIGdhZGdl
dCBpcyBhcm1lZCBieSB0aGUgaG9zdCBmb3IgcmVtb3RlIHdha2V1cC4NCj4gICAqIEBpcnE6IHRo
ZSBpbnRlcnJ1cHQgbnVtYmVyIGZvciBkZXZpY2UgY29udHJvbGxlci4NCj4gICAqIEBpZF9udW1i
ZXI6IGEgdW5pcXVlIElEIG51bWJlciBmb3IgZW5zdXJpbmcgdGhhdCBnYWRnZXQgbmFtZXMgYXJl
IGRpc3RpbmN0DQo+ICAgKg0KPiBAQCAtNDQ0LDYgKzQ0Nyw4IEBAIHN0cnVjdCB1c2JfZ2FkZ2V0
IHsNCj4gIAl1bnNpZ25lZAkJCWRlYWN0aXZhdGVkOjE7DQo+ICAJdW5zaWduZWQJCQljb25uZWN0
ZWQ6MTsNCj4gIAl1bnNpZ25lZAkJCWxwbV9jYXBhYmxlOjE7DQo+ICsJdW5zaWduZWQJCQlyd19j
YXBhYmxlOjE7DQo+ICsJdW5zaWduZWQJCQlyd19hcm1lZDoxOw0KPiAgCWludAkJCQlpcnE7DQo+
ICAJaW50CQkJCWlkX251bWJlcjsNCj4gIH07DQo+IEBAIC02MDAsNiArNjA1LDcgQEAgc3RhdGlj
IGlubGluZSBpbnQgZ2FkZ2V0X2lzX290ZyhzdHJ1Y3QgdXNiX2dhZGdldCAqZykNCj4gICNpZiBJ
U19FTkFCTEVEKENPTkZJR19VU0JfR0FER0VUKQ0KPiAgaW50IHVzYl9nYWRnZXRfZnJhbWVfbnVt
YmVyKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQpOw0KPiAgaW50IHVzYl9nYWRnZXRfd2FrZXVw
KHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQpOw0KPiAraW50IHVzYl9nYWRnZXRfc2V0X3JlbW90
ZXdha2V1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0LCBpbnQgc2V0KTsNCj4gIGludCB1c2Jf
Z2FkZ2V0X3NldF9zZWxmcG93ZXJlZChzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KTsNCj4gIGlu
dCB1c2JfZ2FkZ2V0X2NsZWFyX3NlbGZwb3dlcmVkKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQp
Ow0KPiAgaW50IHVzYl9nYWRnZXRfdmJ1c19jb25uZWN0KHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRn
ZXQpOw0KPiBAQCAtNjE1LDYgKzYyMSw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHVzYl9nYWRnZXRf
ZnJhbWVfbnVtYmVyKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQpDQo+ICB7IHJldHVybiAwOyB9
DQo+ICBzdGF0aWMgaW5saW5lIGludCB1c2JfZ2FkZ2V0X3dha2V1cChzdHJ1Y3QgdXNiX2dhZGdl
dCAqZ2FkZ2V0KQ0KPiAgeyByZXR1cm4gMDsgfQ0KPiArc3RhdGljIGlubGluZSBpbnQgdXNiX2dh
ZGdldF9zZXRfcmVtb3Rld2FrZXVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQsIGludCBzZXQp
DQo+ICt7IHJldHVybiAwOyB9DQo+ICBzdGF0aWMgaW5saW5lIGludCB1c2JfZ2FkZ2V0X3NldF9z
ZWxmcG93ZXJlZChzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KQ0KPiAgeyByZXR1cm4gMDsgfQ0K
PiAgc3RhdGljIGlubGluZSBpbnQgdXNiX2dhZGdldF9jbGVhcl9zZWxmcG93ZXJlZChzdHJ1Y3Qg
dXNiX2dhZGdldCAqZ2FkZ2V0KQ0KPiAtLSANCj4gMi43LjQNCj4gDQoNClRoYW5rcywNClRoaW5o
