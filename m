Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25115651A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiLTGDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiLTGDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:03:03 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E809140ED;
        Mon, 19 Dec 2022 22:03:02 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK5oAo3002744;
        Mon, 19 Dec 2022 22:02:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=gwKVSs0oRSoub0tl8yot0t5evBovXjUfz1CYChmspAY=;
 b=npesdwNLze6GY83LMKBrur+DSj8PzlHLjZA3INGblmniZY7vxy8BiA9DlkguW0wwIJZf
 m5xbbzvY4gqz3V+uvkVzJfQVOVkfTURqxS1gVyrlTXKuBGkyooOy6gUP02ZOmS9bEVot
 zl/0GyX4Hb9dScIniFJieMLJd16z74aeigwBfxPVRtk9zkwzv7FyDQqvVYeLNQX/pNN4
 nTQzWbRQ0D4JbcoZe4bqBZOaiq+hDlpZT8vvwqa8qVpv8PQGlar5tRReGtOZKeZVHK9p
 HIHwWOe1xlNHQfEQuV1fVXqR9xZRmwv12NgC5vcSQr/WJa1umVHHJ8HTAVJpxmYQ6j2O hw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3mhdk0cc20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:02:40 -0800
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 469ADC00AF;
        Tue, 20 Dec 2022 06:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1671516159; bh=gwKVSs0oRSoub0tl8yot0t5evBovXjUfz1CYChmspAY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RG+hAsyxspFbv9RS7k8ZHyuQrWk7rpLb0DPY8ri9u2W7ICtw/35jMWlmUuL33WNgZ
         n2KJK0Ozn48Wf70FhUKpS8A/M41AaIrv2hcmwFRfzfVBw5xfbBNqREnO6uTPW2NPK0
         sBVmb8JMogFc6xSQfeAez5qraWJHqhSN5dMKmUOEmNQyof20EZuLqitXWEPecS58bV
         sLxqNT6NZiz/SH8L+tfoACzObUWonJLibd5X8+yrORza6yZuxgM3b9GDLt1FpT+1v8
         eezpwNznJ5d0riUZjR7ceksPZ4lhofrul7lxXAP/Sf2IlCddG+k2NsWrtRQBgxPNKM
         9zI288ZrgQcNw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5E18BA0073;
        Tue, 20 Dec 2022 06:02:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 92CF840142;
        Tue, 20 Dec 2022 06:02:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="LBu3FyvB";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0oiCnTAmm/LrH8zNniK//05391AcPij2pDvuifAWGaDkgLVbUPPJFIapsXNSIdsJYHef5mZM6BJY0Wh0+4AH7IvGZxWT4oJwBOuFTpNzVkEZojLfufA4UEhsmyybuQzpkeV1YT5+D5lMFmKQiti/j3Ochsta4Oze2AayDAKcOY1J9PoJbADQ/81/nsr4vj9/fRXzhStVGWmVJt2vShobrvl0XKQqPkgQqsvXBNi2u5LX74tCdJUAbjETo/pEdAgFcE/eImN2wjXoO/TpOH62nTfBtbu9rJtpDJiDdOvJEbsDPghp0xIg66Aj1xiKuu+/HZEWo9+ncyNDUSbsWGjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwKVSs0oRSoub0tl8yot0t5evBovXjUfz1CYChmspAY=;
 b=RPCb48iNTl3ALADwBoTVnM9iv8kE+OuGGZPDL13JITKWUJjqUx1rUTYi8ablVMSyOtVeJYwEsNtiyGW4eAvzP+KmxS7dI/29hXTWmnBOClXI8yFAnkKmWm6n4GBex9iwVtWwPg0kegAynynCliTOulfttShr1sLGzXZj4TSGFMTzrCf7OVrpjOd6IHgV0oGU02IyORkVYqfGK/kknhGSfgSQ/bORSQxb9Zfp7iIKv9Vy7kN3qUaLV5fzsQdZ8s5GEKwtlwfyqZGe9l8UtqkH0+eokt+2m9G0WHsyZXJ2KdV6EkpQtb2mHbXz2NGa3ORp/nusw4AJ17SXG+FkOljhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwKVSs0oRSoub0tl8yot0t5evBovXjUfz1CYChmspAY=;
 b=LBu3FyvBF+glnR3L9EKF1Kyck7jcCH/cQLBj96iz7ZZX3fHzGe/joCj4VQraxRYgCLMKxaRUieYTYsinl9CpQqHxAfMMLXCfEhBtCQ5tI5F8+xIF7YsImaOi7gQslNFuAwaU9QqrFot3wey7IdlTZFvk0YckDkeZoTqQH1FRVDo=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 06:02:34 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::72cb:134:53d3:289e]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::72cb:134:53d3:289e%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 06:02:34 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Quentin Schulz <foss+kernel@0leil.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bin Yang <yangbin@rock-chips.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: RE: [PATCH v2 2/2] usb: dwc2: prevent core PHY initialization on
 Rockchip
Thread-Topic: [PATCH v2 2/2] usb: dwc2: prevent core PHY initialization on
 Rockchip
Thread-Index: AQHZEWuubtGaMjzb80KClfaHqWlgUK52RKtg
Date:   Tue, 20 Dec 2022 06:02:34 +0000
Message-ID: <BYAPR12MB339982A244FBA1178423E529A7EA9@BYAPR12MB3399.namprd12.prod.outlook.com>
References: <20221206-dwc2-gadget-dual-role-v2-0-0de821615dd3@theobroma-systems.com>
 <20221206-dwc2-gadget-dual-role-v2-2-0de821615dd3@theobroma-systems.com>
In-Reply-To: <20221206-dwc2-gadget-dual-role-v2-2-0de821615dd3@theobroma-systems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYUcxcGJtRnpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RaVEpqTURGaE5XUXRPREF5WWkweE1XVmtMV0l3TlRRdE5XTTFaalkz?=
 =?utf-8?B?Tmpka05EaGlYR0Z0WlMxMFpYTjBYR1V5WXpBeFlUVmxMVGd3TW1JdE1URmxa?=
 =?utf-8?B?QzFpTURVMExUVmpOV1kyTnpZM1pEUTRZbUp2WkhrdWRIaDBJaUJ6ZWowaU1q?=
 =?utf-8?B?QXpPQ0lnZEQwaU1UTXpNVFU1T0RrM05UQTJNalE1TVRnM0lpQm9QU0pPWjNo?=
 =?utf-8?B?V1NVVlhWbE52Y1dsbk5FdHhTMVZaY1N0WFlYTkdTSE05SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGSVdVbEJRVVJxSzFNcmJFOUNWRnBCWVhOVlVYbHhTVFIzVFd4eGVG?=
 =?utf-8?B?SkVTMjlxYWtGNVZVNUJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlNFRkJRVUZCUjBOQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UlVGQlVVRkNRVUZCUVRKWE1DOXZaMEZCUVVGQlFVRkJRVUZCUVVGQlFVbzBR?=
 =?utf-8?B?VUZCUW0xQlIydEJZbWRDYUVGSE5FRlpkMEpzUVVZNFFXTkJRbk5CUjBWQllt?=
 =?utf-8?B?ZENkVUZIYTBGaVowSnVRVVk0UVdSM1FtaEJTRkZCV2xGQ2VVRkhNRUZaVVVK?=
 =?utf-8?B?NVFVZHpRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdk?=
 =?utf-8?B?QlFVRkJRVUZ1WjBGQlFVZFpRV0ozUWpGQlJ6UkJXa0ZDZVVGSWEwRllkMEoz?=
 =?utf-8?B?UVVkRlFXTm5RakJCUnpSQldsRkNlVUZJVFVGWWQwSnVRVWRaUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZhWjBKMlFVaFZRV0puUW10QlNF?=
 =?utf-8?B?bEJaVkZDWmtGSVFVRlpVVUo1UVVoUlFXSm5RbXhCU0VsQlkzZENaa0ZJVFVG?=
 =?utf-8?B?WlVVSjBRVWhOUVdSUlFuVkJSMk5CV0hkQ2FrRkhPRUZpWjBKdFFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJTalJCUVVGQ2JVRkhPRUZr?=
 =?utf-8?B?VVVKMVFVZFJRV05uUWpWQlJqaEJZMEZDYUVGSVNVRmtRVUoxUVVkVlFXTm5R?=
 =?utf-8?B?bnBCUmpoQlkzZENkRUZIYTBGWmQwRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVGQlowRkJRVUZCUVc1blFV?=
 =?utf-8?B?RkJSMWxCWW5kQ01VRkhORUZhUVVKNVFVaHJRVmgzUW5kQlIwVkJZMmRDTUVG?=
 =?utf-8?B?SE5FRmFVVUo1UVVoTlFWaDNRbnBCU0ZGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJRVUZCUVVGQlFVRkJRMEZC?=
 =?utf-8?B?UVVGQlFVTmxRVUZCUVZwblFuWkJTRlZCWW1kQ2EwRklTVUZsVVVKbVFVaEJR?=
 =?utf-8?B?VmxSUW5sQlNGRkJZbWRDYkVGSVNVRmpkMEptUVVoUlFXTjNRblJCUjAxQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZDUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVsQlFVRkJRVUZLTkVGQlFVSnRRVWM0UVdSUlFuVkJSMUZCWTJk?=
 =?utf-8?B?Q05VRkdPRUZqUVVKb1FVaEpRV1JCUW5WQlIxVkJZMmRDZWtGR09FRmtVVUow?=
 =?utf-8?B?UVVkTlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJtZEJRVUZIWTBGa1FVSjZR?=
 =?utf-8?B?VVk0UVdOQlFubEJSemhCV2tGQ01VRkhUVUZrUVVKbVFVaFJRV05uUW1oQlIy?=
 =?utf-8?B?dEJZbWRDY0VGSE5FRmFkMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVG?=
 =?utf-8?B?QlkzZENhRUZIZDBGYVVVSjZRVVk0UVZsUlFtcEJSMDFCWW5kQ01VRkhORUZr?=
 =?utf-8?B?UVVKbVFVaEJRV0pCUW1oQlJ6UkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJR?=
 =?utf-8?B?VUZCUVVvMFFVRkJRbnBCUjBWQllrRkNiRUZJVFVGWWQwSjRRVWhWUVdKM1Fq?=
 =?utf-8?B?QkJSMVZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRV2RCUVVGQlFVRnVaMEZCUVVoTlFXSm5RbmRCU0UxQldIZENjMEZI?=
 =?utf-8?B?YTBGWmQwSnNRVWMwUVdOM1FteEJSamhCWkVGQ2JFRklTVUZpVVVKbVFVUkZR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCVVVGQlFVRkJRVUZCUVVOQlFVRkJRVUZEWlVGQlFVRmpkMEoxUVVoQlFX?=
 =?utf-8?B?TjNRbVpCUjNkQllWRkNha0ZIVlVGaVowSjZRVWRWUVZoM1FqQkJSMVZCWTJk?=
 =?utf-8?B?Q2RFRkdPRUZqZDBJd1FVaFZRVnBCUW14QlJ6UkJaRUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlNqUkJRVUZD?=
 =?utf-8?B?TWtGSFkwRllkMEp5UVVkVlFXVlJRak5CUnpoQlkyZENhMEZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBGQlFV?=
 =?utf-8?Q?FBQSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|DM6PR12MB4185:EE_
x-ms-office365-filtering-correlation-id: a3c16d7b-4433-4a4b-ace0-08dae24fc9b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J3E1lOOFg4yDVn2Obvc17Gwa2Jkx9nhoz43optVIvVBUT00m841b8pyj1QI43TM30crOp7zMNi+omwYxnA3ECm7gMbBtgzzIAfXY8iaFizuj0hzMy2JiOELCFyQADn5Cb8Jiuj1ZSdwCy42I0Q4HMG1t0yEckyfHcNVwZLQrr/A0Pdm75X4gjfwneSuE3SusaA9RbHk3iJK2lrF1OnuDqntuG5ixnwg5PWwgca3MPIkW453PIuPiGh9fnSQPw4eC6oOTHp+q7b8fuy3aGZBGA0o/ssVotEcJ82x71rRbM3kjeniJAim8yLBg/llz3Ltzv07Y84BNGvis6QwnzNdRrFyqZr3ddf1tOzR18gIu7uaaMbtA0CVxxtOtu0T3Ob5oyb5gjBRkzISbRFdDpPTt9nUwcHGcQcrFepA6x5kiSBnmkB7KaainXPayx3uVhhUhA0n7spzQV2vNec9Pt8SdvroOAIQIexAef0puetyaws5P42Gm3N5ilGMCW26CYp5NrHHiooEXMJgj+mJD3/O0zwBSPdCgDv4C/yU1/QSclfevBQxXvJnHFFj2Wu/B9LWdmxtJWqOMz9erLItjve1TXBr64D0nbys2y7aHKtW3A5rv6KO1LN0EJLnHbN5GPoI5gxFgWOargr1jruRZEeeBWHhHIlzZiDHt0BB1NRNkmw3GdDVAG/i09e/v+6cOU22Kxri6uy3vOKRzUUA7lX65Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(186003)(26005)(9686003)(316002)(71200400001)(110136005)(54906003)(4326008)(66476007)(8676002)(64756008)(66446008)(66946007)(76116006)(53546011)(7696005)(478600001)(66556008)(6506007)(83380400001)(5660300002)(8936002)(41300700001)(2906002)(122000001)(38070700005)(38100700002)(52536014)(33656002)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WS9CYXc2dSsrSDliUktHR0pPWnFhSllDaEZybGlTcFdLaU1neWdQSUhaSWVt?=
 =?utf-8?B?TnZQRkJwMGVSRHpiRXRHczZ0WlpsNHo3OTFlcm9IallJOW9INVdCdXJvcEhy?=
 =?utf-8?B?TkFPYXBhcEJidElScGRUeElVK1J1aFdmbWlDUkNqN0lHcjJCL3hjTk1ZTG16?=
 =?utf-8?B?bUN1RUl0NUxJbVZ3UFlVK1JyQmpHeGt6ZG1EQWE3ai9vcGlOMlRUSDQyODZt?=
 =?utf-8?B?cXNrQzVtYVFPTUN1dnMrK3Y5eGN3MTJtaStBNWVPOG11eUZVS29EUStyTkJo?=
 =?utf-8?B?TmRrZHpmSXhETTY2QXRZanJOelVjbko4VHUyeXhtd2grMHFCUE1DWFlqYlp1?=
 =?utf-8?B?SUhhbEU2WTZxR3N3SEg1bnFtdWJMcVJBeEo4MFVhd2dyMjNrYmlyVG9paDRS?=
 =?utf-8?B?TGZOQnFqbTZIaktkQ3VjbHh1bnpuL3pvRzg3enVieDU2YXQwTmFzY1VXdmdU?=
 =?utf-8?B?RmVwUWpwaEUwbG9HYWxNejBLR2VKRnNEVEQ5V2RaVHltRytpTGZSU0dwbUR3?=
 =?utf-8?B?aXpRaVg4MDhpdHN0VU12V1d0blhtU2cwUDlYc0JwT05nOUx6Qm12THgyTEYv?=
 =?utf-8?B?Z01kTFRsTUdlWHFFcDVLc1p2MzBYNEVkNmZ0a3B5eXpPTzl2TUpyUlh0Skls?=
 =?utf-8?B?TE5pNSs0ZVFKeW1sbkxPSDRFZjNiZy9xRFJwYUJhODFMMHBSaCtFbUhOeGFu?=
 =?utf-8?B?Rk8yV3p3NHVyU3NhSzhWNUFtL3NxNng2UGU2SWpxWVZvRE9tUEFPR2xlRkh2?=
 =?utf-8?B?ZEtsejY2TDZqRmlFOGVIZ0huYXMzNnpLbnJsTGZ3RXd6S3dvYTR1TEUxM1dz?=
 =?utf-8?B?dlU3MFg3alRyVXRzbzczWmdKOFRzRERBVWdXYjZkYm91aVppa295VUU1eWNz?=
 =?utf-8?B?aUpNUGZkNUlSeVpmSzhKTUllM2FxS2NuZHV3RlRsQVlGNzQxNDd0QVphMjB6?=
 =?utf-8?B?YVg0VlRST2tFRGRKNVlxbkVCYlpwUjJyUElqdG43ZEhRbE4yVGErT0RlWW1K?=
 =?utf-8?B?am1RSm9UWFBWQkJpT25PdHF4S2ltbWg2WGhHNWs4ZDZOSGdPZDYweGdDTmFP?=
 =?utf-8?B?NG4zVU5URHF3azQrQnNXOHNGb25oaEtLb2FTZkRBZWJ0QVZqN25JbTV5Nmta?=
 =?utf-8?B?dzdmeWplL3ZvSGhnYUNldGk3c1NzcHZiTktEdTRBd1NzVjlMU1U0VGNZR3dB?=
 =?utf-8?B?TjdtVldnVm9uNDJncGROdFg3c2Z5UzZ0Nkh5Q0VrUGhReWxGOFN1NjJLS1Mv?=
 =?utf-8?B?SlRuUG1PSjB0bnkyRzBTc3FpZXNEMkhxaHRhR1JvVGNLR3RSdHI0YkdLZzlq?=
 =?utf-8?B?RWl0RnNPNEJweXdXOWhtL3ptRmVPZm5ncVh2WVlqUzhnU21SSmlIQVJjQ0Yy?=
 =?utf-8?B?U2thRWxpOXZQR1NNUmYwdW1MNGg1Rzc0T3BCN1cxblBBQ0p1cmd5cUFmNXQz?=
 =?utf-8?B?VDRnV0x0cXlXNWdVT0RRd1RXdkJFODJ6U1hVQm12N25xRkd2d2FwREY1RXVD?=
 =?utf-8?B?OVNGMEtoM09nTFVsUWZJbVBNVzdWT0dOOU5uNDZEZ0tBc3lGMTFJdXBCNkpp?=
 =?utf-8?B?K0FCaFhoZ08xSkYxbzRlb2ZxZ2VXZlhkd1A2TDhTcUcxOWVOMlgwVE1RTmFh?=
 =?utf-8?B?N3AwajFiRTJPRW9xTVh5WnpoUEl2cjB6ZHNMZ2x3U2g1UjZRZUFSaG5jZ2Zs?=
 =?utf-8?B?cGJwUVdBR2pEeDB0RlFyajcrRm0wLzg5cFJvYlNmckRKWjZBcVlZaGNnak9l?=
 =?utf-8?B?RllJcTFHL0luYWdLY0dnM0NadTJTVEJ6eS9TdlpzS2doRE03cnBVNHU4enNB?=
 =?utf-8?B?TE5uemUxUjd3eWRiZ3lOOU9hNkc4cHp0NXpCM1A0RVNYU3dEb1pCazFnNGpL?=
 =?utf-8?B?V1dkSjE1N080RVIyOXovNE1TNzM4TnpnRXZ0Ykk5bzVsSTY5TUUxSEl5OWJ2?=
 =?utf-8?B?cVpIWGZhK2xac1grNjRqS21rdUNLMFErL2RydDhRU1JkL3dnYzdDUjlJVHJn?=
 =?utf-8?B?U01wSUNGbXRtYTVKR3Z0d1pqNTFqajJMQ3BZWDJvdm14ZGdvQndWM0tKeGZI?=
 =?utf-8?B?c0NkMUFmSmtZMnlXcXpvYnA0b3BVMkFHTmtNU3VNMndDemV2dlBOZUMvcm0v?=
 =?utf-8?Q?0SN4WbnAXYy0tQU0cdmNpSTrH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c16d7b-4433-4a4b-ace0-08dae24fc9b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 06:02:34.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JPqArHnSJ5tyIQEbCsP7DzKF9z0LtPuelSom2qcHwyIggFTGGpALr8yXHhIvuF9dF/Z0KFLNmVeDmIsCJbAQWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
X-Proofpoint-ORIG-GUID: MUDkr1qqS_c96cUo4V3Z6EEuk8YuGp1q
X-Proofpoint-GUID: MUDkr1qqS_c96cUo4V3Z6EEuk8YuGp1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212200050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUXVlbnRpbiwNCg0KT24gMTIvMTYvMjAyMiA4OjI5IFBNLCBRdWVudGluIFNjaHVseiA8Zm9z
cytrZXJuZWxAMGxlaWwubmV0PiB3cm90ZToNCj5Gcm9tOiBRdWVudGluIFNjaHVseiA8Zm9zcytr
ZXJuZWxAMGxlaWwubmV0Pg0KPlNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTYsIDIwMjIgODoyOSBQ
TQ0KPlRvOiBNaW5hcyBIYXJ1dHl1bnlhbiA8aG1pbmFzQHN5bm9wc3lzLmNvbT47IEdyZWcgS3Jv
YWgtSGFydG1hbg0KPjxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj5DYzogUXVlbnRpbiBT
Y2h1bHogPGZvc3Mra2VybmVsQDBsZWlsLm5ldD47IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7
DQo+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQmluIFlhbmcgPHlhbmdiaW5Acm9jay1j
aGlwcy5jb20+OyBRdWVudGluDQo+U2NodWx6IDxxdWVudGluLnNjaHVsekB0aGVvYnJvbWEtc3lz
dGVtcy5jb20+DQo+U3ViamVjdDogW1BBVENIIHYyIDIvMl0gdXNiOiBkd2MyOiBwcmV2ZW50IGNv
cmUgUEhZIGluaXRpYWxpemF0aW9uIG9uDQo+Um9ja2NoaXANCj4NCj5Gcm9tOiBRdWVudGluIFNj
aHVseiA8cXVlbnRpbi5zY2h1bHpAdGhlb2Jyb21hLXN5c3RlbXMuY29tPg0KPg0KPkluIFJvY2tj
aGlwIHZlbmRvciBrZXJuZWwsIHRoZSBjb3JlIFBIWSBpbml0aWFsaXphdGlvbiBpcyBkaXNhYmxl
ZCB3aXRoIHRoZQ0KPmZvbGxvd2luZyBqdXN0aWZpY2F0aW9uOg0KPg0KPiBUaGUgdXNiIHBoeXMg
bmVlZCB0byBiZSBjb250cm9sbGVkIGR5bmFtaWNhbGx5IG9uIHNvbWUgUm9ja2NoaXAgU29Dcy4N
Cj4gU28gc2V0IHRoZSBuZXcgSENEIGZsYWcgd2hpY2ggcHJldmVudHMgVVNCIGNvcmUgZnJvbSB0
cnlpbmcgdG8gbWFuYWdlICBvdXINCj5waHlzLg0KPg0KPlRoaXMgaXMgcmVxdWlyZWQgdG8gZ2V0
IFVTQiBnYWRnZXQgd29ya2luZyBpbiBkdWFsLXJvbGUgbW9kZSBvbiBSaW5nbmVjaw0KPlBYMzAg
U29NIG9uIGEgSGFpa291IERldmtpdC4NCj4NCj5DYzogQmluIFlhbmcgPHlhbmdiaW5Acm9jay1j
aGlwcy5jb20+DQo+U2lnbmVkLW9mZi1ieTogUXVlbnRpbiBTY2h1bHogPHF1ZW50aW4uc2NodWx6
QHRoZW9icm9tYS1zeXN0ZW1zLmNvbT4NCj4tLS0NCj4gZHJpdmVycy91c2IvZHdjMi9wYXJhbXMu
YyB8IDEgKw0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4NCj5kaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMi9wYXJhbXMuYyBiL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMg
aW5kZXgNCj45ZWQ5ZmQ5NTY5NDAuLjkwOTU0MzdiMzIzNiAxMDA2NDQNCj4tLS0gYS9kcml2ZXJz
L3VzYi9kd2MyL3BhcmFtcy5jDQo+KysrIGIvZHJpdmVycy91c2IvZHdjMi9wYXJhbXMuYw0KPkBA
IC0xMTcsNiArMTE3LDcgQEAgc3RhdGljIHZvaWQgZHdjMl9zZXRfcmtfcGFyYW1zKHN0cnVjdCBk
d2MyX2hzb3RnICpoc290ZykNCj4gCXAtPmxwbV9jbG9ja19nYXRpbmcgPSBmYWxzZTsNCj4gCXAt
PmJlc2wgPSBmYWxzZTsNCj4gCXAtPmhpcmRfdGhyZXNob2xkX2VuID0gZmFsc2U7DQo+KwlwLT5o
Y2Rfc2tpcF9waHlfaW5pdGlhbGl6YXRpb24gPSAxOw0KDQpJJ20gbm90IGZhbWlsaWFyIHdpdGgg
YWxsICJyayIgcGxhdGZvcm1zLCBidXQgYXJlIHlvdSBzdXJlIHRoYXQNCnAtPmhjZF9za2lwX3Bo
eV9pbml0aWFsaXphdGlvbiA9IDEgcmVxdWlyZWQgZm9yIGFsbCBvZiB0aGVtPw0KDQo+IH0NCj4N
Cj4gc3RhdGljIHZvaWQgZHdjMl9zZXRfbHRxX3BhcmFtcyhzdHJ1Y3QgZHdjMl9oc290ZyAqaHNv
dGcpDQo+DQo+LS0NCj4yLjM4LjENCg0KVG8gYXZvaWQgYW55IG1pc2ludGVycHJldGF0aW9uIHBs
ZWFzZSBhZGQgdG8gZHdjMl9zZXRfZGVmYXVsdF9wYXJhbXMoKQ0KZnVuY3Rpb24gc2V0dGluZyBo
Y2Rfc2tpcF9waHlfaW5pdGlhbGl6YXRpb24gdG8gMC4NCg0KVGhhbmtzLA0KTWluYXMNCg0K
