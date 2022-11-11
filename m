Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EEE624F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiKKBb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiKKBb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:31:56 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0044B60E8E;
        Thu, 10 Nov 2022 17:31:53 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AANKNID014098;
        Thu, 10 Nov 2022 17:31:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=NTmN88QYy76LsrPaMJuHlYGakoQaUykGkfF/IUx8UoU=;
 b=Z6ogXVYL/+jN5BcGStYjkIJ/BUu04IHuv7ZzzzFG3/uVyWFDI6OUmSP236aT3qn3mW8h
 Rp/cCrYNC8XwhHBOL2pXq0VjgcHSHg/YQXZmd1RPPh3vmCQYI4hv/B7DPjm+OIk+1ymj
 5OX664KhDffpn7msgSn6zdvfnMcXSrFJSWjE7tWX227zvHY/l2iL6ctb7JykLeW95/gI
 jp7LBQkmTtrKixuOhkuP7El0QWHjSpJfu5znU8iWky2Lddz12iUrKUfWN9TtbV6Ay3Z9
 rjbhN0Wh39ZkNh7vUSB2W6nudIj9qlaPRkgYaDuvcjE5/u3rXUD2qs93eUOlM4KS6Coq cA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ks4xcjtsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 17:31:27 -0800
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B4034C0827;
        Fri, 11 Nov 2022 01:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1668130270; bh=NTmN88QYy76LsrPaMJuHlYGakoQaUykGkfF/IUx8UoU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GVKjYVhJjE8WWAUv4v5391VUFqhIO2Nh1tCQIO1uN8Vw8WXIgHiW6kIOgK/5Vv/ju
         u6Cmxi84izFu0HYJCMxED3d0rvnEfY4H1osqC+35tfbdE3evPsbSjh1xBqbdNZtLjW
         BD7bpNxUKw5p6LZTndUz07q6ioCOU3gJ2bmUNVf1lq3+WbwBVckjAoMFk+g3xjiwIR
         IPJnmn9uykHScDJGLT1v/BrbwyL7LIzn1/2XQ41WWDfY1SirT+btLL3+TIvqQO1FF4
         N8z6LiT/1zIrH6pI/JCJNJq7/UP1Sd52fTdvLJW6EvyWYo8kq9aDNX564gxP/Tmvou
         iC6eCmR6LGw6w==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EE1EAA0276;
        Fri, 11 Nov 2022 01:31:07 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 47B34802F3;
        Fri, 11 Nov 2022 01:31:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="jXEySB6d";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7Rs7ZqthEN4xZ8NERS0NIWGBG3f0BqoeOwd8Xq4AKVi+s536rwdzWdHzN5/Rc1IZ2axF+XYQxp8gur/gDISUikM+Qr0Qp0amaXGweAc47TMwlekZTLnDGmOYGtoSTaUFLs8CB450rrXRHcvKy/R7dXwf2D7G5zcnV5gLeGUyfVVbeHevrD2z6+Fy+oVQq//P1q6JTrYT4VPUfKJC2AjwGLhHBORWuKTul5Xxw8HWCWK5BAFGzKV09F/nRts5hZKyUFG/D9GNb4x0w5rMUni+F3lcWcATQ/Ob3nx2vly5hNbz3A1ow9XVxlIqCqbptPlcfpOZoWyIc3c6sNeLTNfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTmN88QYy76LsrPaMJuHlYGakoQaUykGkfF/IUx8UoU=;
 b=gPU2AY85vu3TGq5KxHWv6v0Orn5Kz+YKrqg+9JHo5LHRS7vXfIgZUvVeZ2JT1AfX6QV9XaPjXoaeeiyqLsFa6xfSTPKVd6zf/aU0hC5sIdAgKeaypigs2KkCvHhHDaHgu5LOwhMkYopl+b35lNEMsCOu/aqEXd/IDK3tmHDNgyDwEgWZOAy0fhDBRpuMM05wccjCdJ5Tf7IUIpqFmKvj11gsqK2WDUfsTIbCmBfWNR2kCxu3FjH+wn/OJmGfYIpdtBLvLI3I5YkdjL+y0OUDki1oGFTx4gnFoHeHUReFroaVhYFXU6GeMC1sJMyWG+dzlthU5sBD/OVj5+TB36MiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTmN88QYy76LsrPaMJuHlYGakoQaUykGkfF/IUx8UoU=;
 b=jXEySB6dLXXyN/KlU5tSLay2wSfaOSFEctCvPktMzoX3fCbd8u2vjMk/iIde02t92oUm6X4n9B7278wK+jCTCEt2tI1CHdFzM6h9EQTUpNt9j7vp6Al+WDtUpnErZhuBnG6/JMQabNqs7xx5vnH5R4MF4gkuWW3PN84oZpOtIJE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 01:31:03 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9f62:5df9:ad93:5a1f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9f62:5df9:ad93:5a1f%2]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 01:31:03 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Ferry Toth <fntoth@gmail.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
Thread-Topic: [PATCH v1 1/1] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
Thread-Index: AQHY9IlJN29tIhObE0O0gi/uwdEV+K43R46AgADT/YCAAIQ2gIAAUaAA
Date:   Fri, 11 Nov 2022 01:31:02 +0000
Message-ID: <20221111013048.p6ahttrpbgzpavid@synopsys.com>
References: <20221109221749.8210-1-ftoth@exalondelft.nl>
 <20221110000643.xdoav4c4653x3tjd@synopsys.com>
 <e0545783-0a8f-3cb7-2cae-ced85c91e51d@gmail.com>
 <48e7b906-d7e3-46e3-e2bc-71512a1e64aa@gmail.com>
In-Reply-To: <48e7b906-d7e3-46e3-e2bc-71512a1e64aa@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN0PR12MB6365:EE_
x-ms-office365-filtering-correlation-id: 4e44f17a-208a-4e48-af00-08dac3846564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YGVBp6iHdjF+Ds4dp6d0x//qAbWYEdJw7EOip96O39R0nyPDPPvygfwr0osC/NNtUe6H/u3BkKO+Pu0UD2lazZ0obhZ/g9IHtPpGKOb4Oer2HoKDDNBcAspfCgQiJ25qUGJRbCHGYFwuN8ozWK3tdMdeOdL/ehT/M5WZRDqy/Psev+x1cIeRjnX1CV3iSIJgtc6SVERuCTREkQisDyyGrJasHoJHfyk3DAUHXTK6OZZEG/Bs8xNYRUuM6Zap8vEvsq61e34shBroMthzIQSJIVGh4qI4ksJ6UIvY4Qsk1K5tZ7V4pT3CSxdeVGQBAhAJTY+GT9fsd42bXZf5pAasKaMwt1RRMYRnWuDeR4E84ohshYCCBs2epKBpSyBQAJBJ8yPN8vrUD85O6vrir6on454ZflWg5+uWwyqDRSPG68w1yxsmfJlX7M/FvRaYwOgkgdM3nunNFcwDEEVDBmlLSGdNFEF0hx+QmY+e6ez8+0f7DKdUhP7I5FTdzVvT9NAJYK1bQOeL1CUZFZ0eW+mTrHK4D5aK1BqBIwP0uEWsv1v/oBDyt+gdaRIYpheBMH7NFXGxkN2k+6VyVmttqQ8l2muq5DA3Ml2hrTiCQW2Y62pFvtmZKMvPTon09m4tLOwjj+HXQk8ahAngX1WodKnFd7coScGht0xemj1xQj4CI7UdvEuAnRSJp/jgfw57JzBttLw4Oxy8AHOXLkRPnN6aBJcHU92EFTxLiDg6yQ9Gir1/iFj1WQPqxIOFaOJ4WAE99MTVLQDbBOxDaGxIX8X+Eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(6486002)(54906003)(71200400001)(6916009)(316002)(66446008)(8676002)(64756008)(6506007)(6512007)(4326008)(66476007)(478600001)(53546011)(66946007)(66556008)(26005)(76116006)(41300700001)(2906002)(186003)(5660300002)(8936002)(2616005)(1076003)(83380400001)(122000001)(36756003)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVpRdWNvL0Y1MjBERWV6OXFoMW5LbXlDNWg4TjJPSkZnc1IvOTk4OU45cEFP?=
 =?utf-8?B?QmZHRkdiYUh2RVdwdm5USjZXOWkvd21zMXNTT1NvMHpUU0F2YkJiTlNYVFUx?=
 =?utf-8?B?TWR1dzZ0K2hIOFRyOCtEbC95RkhOK1pOWDRNbUlQUDl0SjIxYlZ1K0ZLQmMz?=
 =?utf-8?B?L2lJeG9KQnV3RWdMRmwzOXFxMkYzclY0TTZqdW80S3lwVVlEU0pCempZblpu?=
 =?utf-8?B?S1VNVk0yb3lYeHN6aU93eXRsNXdPRm5lYW1JQms2OWdBb2hkK2RzN25GNUYv?=
 =?utf-8?B?K1QvYlp2b3dmTGRPcWZqb3d1WjVCeGpFSFZwZFhKQXdYcld4WGl5SmZSdEpI?=
 =?utf-8?B?SkFUU29wV2tQKy9YbnIyRGVncTJ4QzJnVlNIaGJ6RDQxREtWcFFxYU83QkNG?=
 =?utf-8?B?ZmQ5WEpOcnE2S1RzRmsrNFFibXZ3MXh5MTZYeEE5dWxBQkVsQWJ3SU52Tks3?=
 =?utf-8?B?cElIYXYwUWthQ0ozSGo4MkdremFRUVdVNFBneC8xb2VqekVmM2owWEF1N044?=
 =?utf-8?B?TTlkTi94cFVhdVR0dGc1Q3BaYzhuY2YwRVJONktKeWs2QklCamthSzNVTDVk?=
 =?utf-8?B?OER1TXFJckkyak04b3pyU0xtcnNFZzRYZ1FOcCtlK2dPWFVSSmVLR0dkN1RH?=
 =?utf-8?B?Y3lJSnB5bTZCcmh4Q251TFl5L1RpdXhIMjNGOVdDR3dXMDhuQzhUNXVYOUdX?=
 =?utf-8?B?UHRjS1BsR0VRSmV0ckJoQ1RrRDhZSXJ0a3FuVSt3RnJkRmw4NExSanNRZTZT?=
 =?utf-8?B?SlRKSHZLQWUvU0RQWFBkdC91U3lhQnZ5VzFkaW1TTEJKaE5BNE9tdUxBTGlT?=
 =?utf-8?B?MEJBRXdtdm5rZHRkMFNRcDF4WlI3SGZSNzZaaE1HRzR3TlBFQy9MMDdGZ2M0?=
 =?utf-8?B?MFI3ZkRmMHI4ZmNWMS82K201Q0RxWFlJOE81dytzWVVwR2F3Y21KZUt2S3Qr?=
 =?utf-8?B?aklLb1c4ejJsNGdJeno2RlZDYTg5M3RxeGtzcWl3MkdxOFFYSk1MbnpyYmFl?=
 =?utf-8?B?bkZpWmpMUlQxM1BhWEdFcHJxOVg4U0NsKzd5TnZqbGpHLzFMMFlINTYwWDBw?=
 =?utf-8?B?bXZCVlcwaU9YREJCa1g3NlNEZjcxdklFVGtlRG5mUndaanRzVENVMHBtVnlY?=
 =?utf-8?B?Q1o1b0RDcGFpek9YbW83SFA4UmZEUmZqSXBNRnlZYzRlNFhwKzA3U0VpUUw4?=
 =?utf-8?B?dnQxZDFGM2ZKL2NTb3Znc3JSZ0paMVEyaHdUNkFIOWNwenIvaTBhVFpnU3VT?=
 =?utf-8?B?Z0FXMTU4RXhOVkxFUktodFFGdStMS25xYmdjMDBzWkE3VWlrNnprSWkwSnJ4?=
 =?utf-8?B?eG05NVg2ckVuN3ZTWVNhdEdwMEFNYUFJZzN1Rm45emMwZTRYdnV2L3FrRHZ0?=
 =?utf-8?B?cENrTXJsUG5mSHhRVTN0L245b2tBVmo5NVhqVFlGUHJNME9HZGJ6eTVndGNG?=
 =?utf-8?B?VDg1WFNOaEx2SThMVUFVa0hZZUhwS2gwREVrL3VPd21iWGpvdDJqZEZ5LzFY?=
 =?utf-8?B?L2xtN3VjcTJpLzJ3VUxrWU1qMGU2V3lMdXRLTmlMK1hiMjFUdFphY1pla1hz?=
 =?utf-8?B?Yld1ZTB4bU1RNkZ3UjFabGtKbWdWVUhRVXlLSjdWTjR0TVdmbkE0cTI1bG1q?=
 =?utf-8?B?bHp4T1liRVhWM3FiRlFuVk5wS0VRWTVEN09VRkpIVE1RV04vTXFhbDkybDFz?=
 =?utf-8?B?UEdMNlZuaFFnUG0zV0ZTbFdGODFGZlFMSFRlSmVTYWc0SUdwa2NLdWYzbnAr?=
 =?utf-8?B?bjBUU043Mk9JdDZBcndENGJMamJjTWNwMjdWR3EzZlFUd3FTTWlYUWswcG40?=
 =?utf-8?B?NGxwT0diczJ6ME5RaEhBM1JrVVZweStkeDJxZlVtTjdXWlZFQ0l0b1NDNzB1?=
 =?utf-8?B?MHVHRHFuT3I2MUszNHNwdURsdHlzN0lZa1BiZnVJc29CUk1oWWxHR1ZDNWxP?=
 =?utf-8?B?c3krVStHQTVxWXQ5WVQwVGk1alc2SlI5MUNOQ2twQStVVktVYmExNDVLMHVo?=
 =?utf-8?B?Y3ZjYlhQUGdzOTVsUnN3NFBYd0Q5c25GZ0lFOElvVElIVFMrY2YzSFQwTXpx?=
 =?utf-8?B?dmZTYkJIUE95aVJOaUpraXNuZEtGcVVDQ3MrZFRiTkRyZzdPVllnVEpOMkhl?=
 =?utf-8?Q?FsJNgniI15QjSrdYHKlqjpINV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFC2CA4CAB553146AD4712C63C3D856F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e44f17a-208a-4e48-af00-08dac3846564
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 01:31:02.9918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MrX/5XeQRwiUqbC7cFLseM1krwhZ2D+/nihthKVRliPH+EmNeao9LzqZuheHUj+07iYW7ke3l/S373oAqs0RhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
X-Proofpoint-GUID: cVM8BCg5S_UDAtPE7Iakp0mSz_jaH791
X-Proofpoint-ORIG-GUID: cVM8BCg5S_UDAtPE7Iakp0mSz_jaH791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 priorityscore=1501 clxscore=1011 impostorscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBOb3YgMTAsIDIwMjIsIEZlcnJ5IFRvdGggd3JvdGU6DQo+IEhpDQo+IA0KPiBPcCAx
MC0xMS0yMDIyIG9tIDEzOjQ1IHNjaHJlZWYgRmVycnkgVG90aDoNCj4gPiAoc29ycnkgc2VudCBo
dG1sIHdpdGggcHJldmlvdXMgYXR0ZW1wdCkNCj4gPiANCj4gPiBPbiAxMC0xMS0yMDIyIDAxOjA2
LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiBIaSBGZXJyeSwNCj4gPiA+IA0KPiA+ID4gT24g
V2VkLCBOb3YgMDksIDIwMjIsIEZlcnJ5IFRvdGggd3JvdGU6DQo+ID4gPiA+IFNpbmNlIGNvbW1p
dCAwZjAxMDE3MQ0KPiA+ID4gPiBEdWFsIFJvbGUgc3VwcG9ydCBvbiBJbnRlbCBNZXJyaWZpZWxk
IHBsYXRmb3JtIGJyb2tlIGR1ZSB0byByZWFycmFuZ2luZw0KPiA+ID4gPiB0aGUgY2FsbCB0byBk
d2MzX2dldF9leHRjb24oKS4NCj4gPiA+ID4gDQo+ID4gPiA+IEl0IGFwcGVhcnMgdG8gYmUgY2F1
c2VkIGJ5IHVscGlfcmVhZF9pZCgpIG9uIHRoZSBmaXJzdCB0ZXN0DQo+ID4gPiA+IHdyaXRlIGZh
aWxpbmcNCj4gPiA+ID4gd2l0aCAtRVRJTUVET1VULiBDdXJyZW50bHkgdWxwaV9yZWFkX2lkKCkg
ZXhwZWN0cyB0byBkaXNjb3Zlcg0KPiA+ID4gPiB0aGUgcGh5IHZpYQ0KPiA+ID4gPiBEVCB3aGVu
IHRoZSB0ZXN0IHdyaXRlIGZhaWxzIGFuZCByZXR1cm5zIDAgaW4gdGhhdCBjYXNlIGV2ZW4gaWYN
Cj4gPiA+ID4gRFQgZG9lcyBub3QNCj4gPiA+ID4gcHJvdmlkZSB0aGUgcGh5LiBEdWUgdG8gdGhl
IHRpbWVvdXQgYmVpbmcgbWFza2VkIGR3YzMgcHJvYmUgY29udGludWVzIGJ5DQo+ID4gPiA+IGNh
bGxpbmcgZHdjM19jb3JlX3NvZnRfcmVzZXQoKSBmb2xsb3dlZCBieSBkd2MzX2dldF9leHRjb24o
KQ0KPiA+ID4gPiB3aGljaCBoYXBwZW5zDQo+ID4gPiA+IHRvIHJldHVybiAtRVBST0JFX0RFRkVS
LiBPbiBkZWZlcnJlZCBwcm9iZSB1bHBpX3JlYWRfaWQoKQ0KPiA+ID4gPiBmaW5hbGx5IHN1Y2Nl
ZWRzLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBwYXRjaCBjaGFuZ2VzIHVscGlfcmVhZF9pZCgp
IHRvIHJldHVybiAtRVRJTUVET1VUIHdoZW4gaXQNCj4gPiA+ID4gb2NjdXJzIGFuZA0KPiA+ID4g
PiBjYXRjaGVzIHRoZSBlcnJvciBpbiBkd2MzX2NvcmVfaW5pdCgpLiBJdCBoYW5kbGVzIHRoZSBl
cnJvciBieSBjYWxsaW5nDQo+ID4gPiA+IGR3YzNfY29yZV9zb2Z0X3Jlc2V0KCkgYWZ0ZXIgd2hp
Y2ggaXQgcmVxdWVzdHMgLUVQUk9CRV9ERUZFUi4gT24NCj4gPiA+ID4gZGVmZXJyZWQNCj4gPiA+
ID4gcHJvYmUgdWxwaV9yZWFkX2lkKCkgYWdhaW4gc3VjY2VlZHMuDQo+ID4gPiA+IA0KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBGZXJyeSBUb3RoPGZ0b3RoQGV4YWxvbmRlbGZ0Lm5sPg0KPiA+ID4g
PiAtLS0NCj4gPiA+ID4gwqAgZHJpdmVycy91c2IvY29tbW9uL3VscGkuYyB8IDUgKysrLS0NCj4g
PiA+ID4gwqAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmPCoMKgIHwgNSArKysrLQ0KPiA+ID4gPiDC
oCAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+
ID4gDQo+ID4gPiBDYW4geW91IHNwbGl0IHRoZSBkd2MzIGNoYW5nZSBhbmQgdWxwaSBjaGFuZ2Ug
dG8gc2VwYXJhdGUgcGF0Y2hlcz8NCj4gPiANCj4gPiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMu
DQo+ID4gDQo+ID4gSSB3aWxsIHNlbmQgdjINCj4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2NvbW1vbi91bHBpLmMgYi9kcml2ZXJzL3VzYi9jb21tb24vdWxwaS5jDQo+ID4g
PiA+IGluZGV4IGQ3Yzg0NjE5NzZjZS4uZDhmMjJiYzJmOWQwIDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL3VzYi9jb21tb24vdWxwaS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2Nv
bW1vbi91bHBpLmMNCj4gPiA+ID4gQEAgLTIwNiw4ICsyMDYsOSBAQCBzdGF0aWMgaW50IHVscGlf
cmVhZF9pZChzdHJ1Y3QgdWxwaSAqdWxwaSkNCj4gPiA+ID4gwqDCoMKgwqDCoCAvKiBUZXN0IHRo
ZSBpbnRlcmZhY2UgKi8NCj4gPiA+ID4gwqDCoMKgwqDCoCByZXQgPSB1bHBpX3dyaXRlKHVscGks
IFVMUElfU0NSQVRDSCwgMHhhYSk7DQo+ID4gPiA+IC3CoMKgwqAgaWYgKHJldCA8IDApDQo+ID4g
PiA+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIGVycjsNCj4gPiA+ID4gK8KgwqDCoCBpZiAocmV0IDwg
MCkgew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4gPiA+ID4gK8KgwqDC
oCB9DQo+ID4gPiA+IMKgwqDCoMKgwqAgcmV0ID0gdWxwaV9yZWFkKHVscGksIFVMUElfU0NSQVRD
SCk7DQo+ID4gPiA+IMKgwqDCoMKgwqAgaWYgKHJldCA8IDApDQo+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4g
PiA+IGluZGV4IDY0OGYxYzU3MDAyMS4uZTI5M2VmNzAwMzliIDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPiA+ID4gPiBAQCAtMTEwNiw4ICsxMTA2LDExIEBAIHN0YXRpYyBpbnQgZHdjM19j
b3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ID4gwqDCoMKgwqDCoCBpZiAoIWR3Yy0+
dWxwaV9yZWFkeSkgew0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gZHdjM19jb3Jl
X3VscGlfaW5pdChkd2MpOw0KPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkNCj4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZXQpIHsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZHdjM19jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCj4gPiA+IFdlIHNob3VsZG4ndCBuZWVk
IHRvIGRvIHNvZnQgcmVzZXQgaGVyZS4gVGhlIGNvbnRyb2xsZXIgc2hvdWxkbid0IGJlIGF0DQo+
ID4gPiBhIGJhZC9pbmNvcnJlY3Qgc3RhdGUgYXQgdGhpcyBwb2ludCB0byB3YXJyYW50IGEgc29m
dC1yZXNldC4gVGhlcmUgd2lsbA0KPiA+ID4gYmUgYSBzb2Z0LXJlc2V0IHdoZW4gaXQgZ29lcyB0
aHJvdWdoIHRoZSBpbml0aWFsaXphdGlvbiBhZ2Fpbi4NCj4gPiANCj4gPiBJdCBkb2Vzbid0IGdv
IHRocm91Z2ggdGhlIGluaXRpYWxpemF0aW9uIGFnYWluIHVubGVzcyB3ZSBzZXQNCj4gPiAtRVBS
T0JFX0RFRkVSLiBBbmQgd2hlbiB3ZSBtYWtlIHVscGlfcmVhZF9pZCgpIHJldHVybiAtRVBST0JF
X0RFRkVSIGl0DQo+ID4gd2lsbCBnb3RvIGVycjAgaGVyZSwgc28gc2tpcHMgZHdjM19jb3JlX3Nv
ZnRfcmVzZXQuDQo+ID4gDQo+ID4gRG8geW91IG1lYW4geW91IHByZWZlciBzb21ldGhpbmcgbGlr
ZToNCj4gPiANCj4gPiBpZiAocmV0KSB7DQo+ID4gDQo+ID4gIMKgwqDCoCBpZiAocmV0ID09IC1F
VElNRURPVVQpIHJldCA9IC1FUFJPQkVfREVGRVI7DQo+ID4gDQo+ID4gIMKgwqDCoCBlbHNlIGdv
dG8gZXJyMDsNCg0KV2h5ICJlbHNlIj8gQnV0IEkgc2F3IHlvdSByZW1vdmUgdGhhdCBpbiB0aGUg
bmV3IHBhdGNoLg0KDQo+ID4gDQo+ID4gfQ0KPiANCj4gSSBqdXN0IHRlc3RlZCwgYW5kIGNhbGxp
bmcgZHdjM19jb3JlX3NvZnRfcmVzZXQoKSBwcm92ZXMgdG8gYmUgbmVjZXNzYXJ5IGFzDQo+IHdl
IG5lZWQgdG8gZ290byBlcnIwIGRpcmVjdGx5IGFmdGVyLiBFbHNlIHJldCBpcyBvdmVyd3JpdHRl
biBhbmQNCj4gLUVQUk9CRV9ERUZFUiBsb3N0Lg0KDQpMb29rcyBsaWtlIHRoZXJlJ3MgYSBzdHJh
bmdlIGRlcGVuZGVuY3kgcHJvYmxlbSBoZXJlLg0KICogVGhlIHNldHVwIG5lZWRzIGEgc29mdC1y
ZXNldCBiZWZvcmUgdWxwaSByZWdpc3RyYXRpb24NCiAqIFRoZSB1bHBpIHJlZ2lzdHJhdGlvbiBu
ZWVkcyB0byBnbyBiZWZvcmUgdGhlIHBoeSBpbml0aWFsaXphdGlvbg0KICogVGhlIHNvZnQtcmVz
ZXQgc2hvdWxkIGJlIGNhbGxlZCBhZnRlciB0aGUgcGh5IGluaXRpYWxpemF0aW9uDQoNCkkgY2Fu
J3QgZXhwbGFpbiB0aGUgYWN0dWFsIGlzc3VlIGhlcmUsIGFuZCB3ZSBjYW4ndCBkZWJ1ZyBmdXJ0
aGVyDQpiZWNhdXNlIHRvIGxvb2sgaW50byBpdCBmdXJ0aGVyIHdvdWxkIHJlcXVpcmUgbG9va2lu
ZyBhdCBpbnRlcm5hbA0Kc2lnbmFscy4NCg0KVGhpcyBzb2Z0LXJlc2V0IGFuZCAtRVBST0JFX0RF
RkVSIHNlZW1zIHRvIGJlIGEgd29ya2Fyb3VuZCB0byB0aGlzDQpkZXBlbmRlbmN5IHByb2JsZW0u
IEluc3RlYWQgb2YgdXNpbmcgLUVQUk9CRV9ERUZFUiwgY2FuIHlvdSBkbyB0aGlzOg0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KaW5kZXggMmYwYTk2Nzk2ODZmLi41YTFhYWYzNzQxZWMgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuYw0KKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCkBAIC0xMDk3
LDYgKzEwOTcsOCBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2Mp
DQogICAgICAgICAgICAgICAgZ290byBlcnIwOw0KIA0KICAgICAgICBpZiAoIWR3Yy0+dWxwaV9y
ZWFkeSkgew0KKyAgICAgICAgICAgICAgIC8qIEFkZCBjb21tZW50ICovDQorICAgICAgICAgICAg
ICAgZHdjM19jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCiAgICAgICAgICAgICAgICByZXQgPSBkd2Mz
X2NvcmVfdWxwaV9pbml0KGR3Yyk7DQogICAgICAgICAgICAgICAgaWYgKHJldCkNCiAgICAgICAg
ICAgICAgICAgICAgICAgIGdvdG8gZXJyMDsNCg0KDQo+IA0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXQgPSAtRVBST0JFX0RFRkVSOw0KPiA+ID4gV2Ugc2hvdWxkbid0IGF1dG9t
YXRpY2FsbHkgc2V0IGV2ZXJ5IGVycm9yIHN0YXR1cyB0byBjb3JyZXNwb25kIHRvDQo+ID4gPiAt
RVBST0JFX0RFRkVSLiBDaGVjayBvbmx5IHRoZSBhcHByb2FwcmlhdGUgZXJyb3IgY29kZXMgKC1F
VElNRURPVVQgKw0KPiA+ID4gYW55IG90aGVyPykuDQo+ID4gT3RoZXIgY291bGQgYmUgLUVOT01F
TS4gSSB0aGluayBubyBuZWVkIHRvIGRvIGFueSBuZXcgaGFuZGxpbmcgZm9yIHRoYXQuDQoNClRo
ZXJlJ3MgYWxzbyAtRUlOVkFMIGFuZCBzb21lIG90aGVycyB0b28uIFJlZ2FyZGxlc3MsIGlmIGl0
J3MgLUVOT01FTSwNCnRoZW4gaXQgc2hvdWxkIG5vdCByZXR1cm4gLUVQUk9CRV9ERUZFUi4NCg0K
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycjA7DQo+ID4gPiA+ICvC
oMKgwqDCoMKgwqDCoCB9DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBkd2MtPnVscGlfcmVh
ZHkgPSB0cnVlOw0KPiA+ID4gPiDCoMKgwqDCoMKgIH0NCj4gPiA+ID4gDQoNClRoYW5rcywNClRo
aW5o
