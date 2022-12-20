Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07121651A86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiLTGDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiLTGDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:03:15 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4131715A0E;
        Mon, 19 Dec 2022 22:03:14 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK5o1AJ001792;
        Mon, 19 Dec 2022 22:02:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=U4ZXABL5vphFtfk0Ireiq7MxkNtISy7Ytf0hMS0+Zjk=;
 b=EvHrH+HdjTVHCGN3ehyfIkZGU6ck4IrUst4QlKe8heQvu+XxWHda2Uewh1rFpSVlcIw6
 bfWDgZ52+27Xww6eSbOfCKAGMzq22FqGiOAZbjrWSepzsg0/IaVADWHgTjCYY+69OFEO
 X/homGPI9GhWvxX+VJ1zzb6ivpdZCDXZ3Y+Eoyzqr7w0hsB4jOzz+xOk1774JzjdWykq
 04PNWiQWCp8je+Us09cl7MLbg4qAcKOs487IegEP4opKx4R1ceanhF6bmlohhl4VWANa
 d2Q1Qulge+1bE0F+SZI9Ks4CQHbkUht36ApOJAlA7AXhO6al1VkfEQjtwVYqx3tWB/IR AA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3mhdk0cc3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 22:02:55 -0800
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 62A75C00AF;
        Tue, 20 Dec 2022 06:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1671516174; bh=U4ZXABL5vphFtfk0Ireiq7MxkNtISy7Ytf0hMS0+Zjk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=evDELwdZbc8Usj5CEubBuWdEM+GaLCPoR9RRlINtEyiXvx/u+JQAGpLSvUdWNxENk
         B9HsMl/tlO6yk+P6EYTF7kdSaYMumEPdzA/Jb5w9zeEmeQQdOjGbrlfIT/sMLgRp1L
         9SEjzuWVeKx/RTdLLhog3icB7DMhNDcdgTzOAlYyS/MZzhautF1TJ03pLbUZlQ5Czb
         7A8dmlckFOWusQBiTPmM+8eSvvEk2zPCJrlyLfzZn3XVoEqoIN2XMUNa63Z4b5/bop
         7T+a0lkouQYi7Dn17uAnMvW3UNw68+/nYORAdQgkLGasIcgKvKRrI7TrbcBfekvxgy
         o+64/TATa0xiw==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 097BAA0062;
        Tue, 20 Dec 2022 06:02:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AC0EAA0085;
        Tue, 20 Dec 2022 06:02:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="V5SjR4RD";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk0i1GauRhGtj31x+DZWvlktqdkORiV2iHO04PHJJbKTZd7b9xFNB0/ho1F9bdBh2w7M9Clb8moW/gXq3X4lMUJJELCUNVu29dCXAKb3f2W83wA2WL2WklV600zitQYSwsKh4FE443tqLXkLSXE1kAjd2aU8arCBjhtLL9LirvNLoamECvLYs0k3660+sctXJTaoGfq9hVn8+aIoU/PZUh//vM05YBZi5Tep+l70O6YfzM7FNhLQPL1XnpWvaS66kxrBgWiMoHOANkz4YovVt0VnHNEvS75RXAmISLdpEx1qk4UuCiCvVN1rdr5SqaM8gTgwcF/jqyTpVLmvsA3AxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4ZXABL5vphFtfk0Ireiq7MxkNtISy7Ytf0hMS0+Zjk=;
 b=ZyzWIBw5G8AhuSqm40gEDnAAzEP8IUTdetLtNMLeqCtL4zaufip717lxYVLe9MThN+QpxH+F6YmWyitCjbwP9mhTvAbwUS9PYzwX4LSKacnSe+Sga59kbl8mHJ6ZaIO/YFF6GatAovAQ+3kvK2nhf4wF0O7LGMAPgJk4a+oQgouk6Te06JRPZbmEGf/9dZ6rYQXPGFwe6XPKhZkPgdE/yYEz9WzGixiaZOZzVLB9ZfSFOS/PpS6H014seS3TwkfLVCcMSb5NPpNZHzEtGqJzMcqajGgxlm8fqa3Imrc/PnvYdKnBX10pv+Y1wGZBs+KSo2TmdSsMysHcU4eJp9c8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4ZXABL5vphFtfk0Ireiq7MxkNtISy7Ytf0hMS0+Zjk=;
 b=V5SjR4RDsT8E/uAmwu2Lg3XG4mhELspWa8MCAYgTLtKsKjsGz52Z2FqDbXeNi3XZK7vNzyGvtXEU+2gnr3tPCIoTdEpMTELLGV5zrLMSbn74emR9wUMPvxjvNGvRH8RxkVxKHrau6eE4KtRZ0H7QCO7188/9QiV5mN+uC1aX8Aw=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 06:02:48 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::72cb:134:53d3:289e]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::72cb:134:53d3:289e%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 06:02:47 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Quentin Schulz <foss+kernel@0leil.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bin Yang <yangbin@rock-chips.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: RE: [PATCH v2 0/2] usb: dwc2: fix USB peripheral role in dual-role
 mode on PX30
Thread-Topic: [PATCH v2 0/2] usb: dwc2: fix USB peripheral role in dual-role
 mode on PX30
Thread-Index: AQHZEWur7NMFeACvc0qg34dQjqjw7q52RfDg
Date:   Tue, 20 Dec 2022 06:02:47 +0000
Message-ID: <BYAPR12MB339938A2413F4D40A084F4DCA7EA9@BYAPR12MB3399.namprd12.prod.outlook.com>
References: <20221206-dwc2-gadget-dual-role-v2-0-0de821615dd3@theobroma-systems.com>
In-Reply-To: <20221206-dwc2-gadget-dual-role-v2-0-0de821615dd3@theobroma-systems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYUcxcGJtRnpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RaV0l6WkdZMllUWXRPREF5WWkweE1XVmtMV0l3TlRRdE5XTTFaalkz?=
 =?utf-8?B?Tmpka05EaGlYR0Z0WlMxMFpYTjBYR1ZpTTJSbU5tRTNMVGd3TW1JdE1URmxa?=
 =?utf-8?B?QzFpTURVMExUVmpOV1kyTnpZM1pEUTRZbUp2WkhrdWRIaDBJaUJ6ZWowaU16?=
 =?utf-8?B?WTBNU0lnZEQwaU1UTXpNVFU1T0RrM05qUTROamswTkRjM0lpQm9QU0k1VG5G?=
 =?utf-8?B?WWR6ZE1VRFpYVmxFd05ESlhkMUowVGtwTVZYTm1jVWs5SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGSVdVbEJRVVJPYUVzeWRFOUNWRnBCV1hWNmFrZ3hiV3BxZEhWcE4w?=
 =?utf-8?B?OU5abGRoVDA4eU5FNUJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|SA1PR12MB7127:EE_
x-ms-office365-filtering-correlation-id: 4c36ef6b-a632-44c3-f672-08dae24fd17c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nonTaLvYiFiLtdadpnKGq6DYgqi3a1m82NT+lA32gVedqxXSq7ikS/gA252PoXGL687Uer80JwtljNhOBv4SMjGEVE4F8UMC/CD6p1RWAreG/IOa2QYC8XflVO7Q57dM58cTuHxXGfmtkHjqmsHcDOXk7krasGT98VYowNlykwN3xfbNS80wOEuH7hdbDfX/j5qTjBZhJSGlU8HsrHXMpagQC4HZnENDzPeXsjYRTE8BgY1ANbAvd1qy4ZsV0fe00a7XEOBsL7av1GDkLug4XCiA6N+WAAbl+UjpeFWVg01fAbK+mAV+TkHN6f+vQDmJT6Z9QbPfV9ATrrLk0B645iWRGLR2el3RpXtBIHhhNqT1zRhXI5zPIHEp7o5ZBIohnWnXWC4DIKaeE2zFQFvbVgFouHMB6C/fgWYvijKR3NTdM+eq5mAgBv1JB7xn2DYPJB+A1+Qpbjuc5zl88b5Z1KOaHUG8Q+ICJTNcD+Jl37zitIWS1kjupt5wGevWMeTgLjvzq43vf4weZbPoFNGFqRvK02tYKaU1+IMKPe8E0MdPn+67TSPOEXYzMoyTKGAdyan/kXh2ezWCf1rhdQlQEtWLqGTP2mtW5CPr/x15FmzEg4xpYYfa+YPLN6b4UfRCjqrvIRZxF1kVGB9JIpUWMjDJuK31ylzadAcIaQu0XH/gsne71N1fOGJEL+MvTqgc+eamMuMZh9TRWsCtRgB1fg7PZ4dvUcc4+DfEWA49CUU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(54906003)(33656002)(316002)(110136005)(66476007)(2906002)(38100700002)(55016003)(122000001)(66446008)(76116006)(52536014)(26005)(86362001)(8676002)(8936002)(4326008)(9686003)(186003)(64756008)(478600001)(83380400001)(6506007)(71200400001)(38070700005)(66556008)(66946007)(7696005)(41300700001)(5660300002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWNsMDhsRGx4WWNqY1BsdWZTWlB0ZkpwdlZnRkpIRjJCL2NLSFJsMXE4TjVI?=
 =?utf-8?B?NGw1L0tPMkZnUlo0NkNvV1NmUHFCbTUwU0d2dW00dHlTUjlhc0VZbitjdzJq?=
 =?utf-8?B?VVVLRzhBVHRQSWN5TDhoWU1Md215MnQ5UlJrZGU4R1ZhanV4MFVIdVRsVGhr?=
 =?utf-8?B?SzhjQ3VnUTI4Tkp5RG95ZUx4S3N3VWp1UW9tQnViU25xbzVmVmY3eTdmNmgx?=
 =?utf-8?B?djZNaTFCYUNEbFdCdE12T1dRQnphRWJrNEt5VFRseElGRWwzUWhNRnh5cTF3?=
 =?utf-8?B?N0VnWDhzT0YyMDdRVlN4RkZVeTFybGwyb2p1eUNhc3RVNVZCNkZ0akcwSVNK?=
 =?utf-8?B?bW5lQU1DNGVwYWFjMFhxb1BUaExJZ09NeXlrakhVN0pGM0JyZTltNUhWUG9n?=
 =?utf-8?B?c2czSW1sampCRkFkb0pVMDVySE5aUDFETU1PTWcrS0h2bld5U0d0QXB2WGdv?=
 =?utf-8?B?a3RJU2tpQ2dYU3dNSWRERFczZWFoaWxjdnRYclZFbXViMUtoWjRoazA4R0tw?=
 =?utf-8?B?WnZMdTdhdlRmU2czc3VsdzVOd1FiU2c1QnRMM0VHQ1lMaUVLS3lmeG1NS000?=
 =?utf-8?B?ejZuVnI3Qmt5MW1sUTVhNnhWZzlwY3loUXF1K21DWmZuTnNqemU5QnlYRzVM?=
 =?utf-8?B?UE14RURxNm9sNzA2eVp2U2VRMlZ3VFl1TmM4RmQwTUhNUnhad0pPbnpNdDVV?=
 =?utf-8?B?R2lnL0xNckYrRHZuZWVYWUYzaTZmc25WYUpLcjMzVzlrYXJheVc1b3R1bEov?=
 =?utf-8?B?SlMzeFp3d1F4cFpPMlZsYm8zSjBTaHZ5VVUzQk56RmNrc0dBTFpsVzZ0RlBC?=
 =?utf-8?B?WUFZZEtJUFlhdERhUFF6QXpjUzJPd0h5VHhNU0QzUU5YVHdkNDlJZVE3dTNz?=
 =?utf-8?B?ZXYzRWx5VlZZTEtWUGFNVE5qZm5URzVONjRvTlZNbitsa3dLMFp1WU0vQ2Yx?=
 =?utf-8?B?SUY5R1lmRDJCdGJSWkRkR25aSldFZlVGeVpsbnlpdloxZEduY3FhNWsxdjg2?=
 =?utf-8?B?Y2VTd2c4eEV4VlUwRUVtODVISVhqZDRIZEI2ekIvbkEyNlUxN3owOEMvajFL?=
 =?utf-8?B?eEwrYUVTajAwTGtVMGFnNXoybnN1R1ZaWWJTQkFDVVhiaXI4dFFjWDZNSjFo?=
 =?utf-8?B?UE5zRUhCbWExdjIwWk1oWEd4dCtLWUtXUDNEV2FEOXlWUC8xTjFtd1M0dXVH?=
 =?utf-8?B?R0NKV1RHaFBwV3RrUTJkNDVhcUU0c0hxOTM1MHNFRHJkeUhWY0FLc3o5dmRu?=
 =?utf-8?B?MjZOVzIzQURNdTdvR1l6QzVNUmJBbDJXdTZWN0IvSGVuRVFXdWNCWUtlc1NE?=
 =?utf-8?B?RmQwZFprZXV3VlRGTzRQQ0RsZitHRkx6Uk1HZTVhOE9aUlRwbHNnWFlYaEwv?=
 =?utf-8?B?ZTRKQVBadG1kYzNxRGUvTVB1S1BITi92OXVlR2hoRmVCSWNWUSsvSWhlWTAr?=
 =?utf-8?B?NFZRWm9MRTNuUnFBSkNGcFZZcWh5aGhoM1NVaUxJMnhldXdMVDVBd1RZMUN4?=
 =?utf-8?B?eE1KblIxTUZiZEJVaEUrOWRmQkNETlVVRXMrNklWVndZcXNML2RBQ2NrVDJB?=
 =?utf-8?B?blFtWjNQWHdhWXFNU2V1NVdITW1YUDIrUXV0S0VPczlFcUg3dTkzakx1cnpN?=
 =?utf-8?B?Z29ZUzZ0WmM3cWdYNFBsMyt5YmExYXZXUjVGZklpSWV6VHJPcEEyRGZucFY5?=
 =?utf-8?B?QXZtQkNrckxtRWhpS0xSWnpGOVlYdFJEb05iQlUyUDFXQWQweUROS2JTeCtB?=
 =?utf-8?B?Q1orT2xTVjFZeDRhaXZMNDM3M3NSd3hvV1VKWDZpMzZjc0tsbkVrelhlWnRT?=
 =?utf-8?B?WjlZS1dQTC8wMDZiZUZlOXpsR0c1NURJczJ4OUswa0F0YzNjdjZYQnpySWZP?=
 =?utf-8?B?SmVrTG1rSUladDV1cElKR1dHUDdLajRUc0sxcnVraExXSCtjMW5BMXNDcHZS?=
 =?utf-8?B?MGdCRWVvNXB3RVZpVUJWZ2ZtbCtBV2VIMmtFSUFjbThxR2EyNU5iL3A2NHFS?=
 =?utf-8?B?cW9ZN2prSDgrL2tWWXpzejJFNVB4VFAvNGJkWENmT0JMSm9GaXo2Y0lCbDlN?=
 =?utf-8?B?NXpxbXY2azgrUHovSjNGL1RMK2hEdlExekcvRk9SSGZXS3hMdVpXbmJkRGxJ?=
 =?utf-8?Q?DFa+wajoosH/1QnRhk/23IJoX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c36ef6b-a632-44c3-f672-08dae24fd17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 06:02:47.0642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XZYhJAUFGwwnRW1lRicEW9ibfFY7vX5oSN60uOUaERCMxOKGqwiYVFK5lOK6afwNR0x7bRQkRBZBSWh/MfzJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
X-Proofpoint-ORIG-GUID: 7XVU9tqrzg3Iu5TrxZZxtwxYjfQOmOYq
X-Proofpoint-GUID: 7XVU9tqrzg3Iu5TrxZZxtwxYjfQOmOYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=929 classifier=spam adjust=0
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
dGVtcy5jb20+DQo+U3ViamVjdDogW1BBVENIIHYyIDAvMl0gdXNiOiBkd2MyOiBmaXggVVNCIHBl
cmlwaGVyYWwgcm9sZSBpbiBkdWFsLXJvbGUgbW9kZQ0KPm9uIFBYMzANCj4NCj5PbiBUaGVvYnJv
bWEgUmluZ25lY2sgU29NLCBVU0IgcGVyaXBoZXJhbCByb2xlIHdoZW4gaW4gZHVhbC1yb2xlIG1v
ZGUgZG9lcw0KPm5vdCB3b3JrIGFuZCBkaXNwbGF5cyB0aGUgZm9sbG93aW5nIGVycm9yIG1lc3Nh
Z2U6DQo+ZHdjMiBmZjMwMDAwMC51c2I6IGR3YzJfY29yZV9yZXNldDogSEFORyEgU29mdCBSZXNl
dCB0aW1lb3V0IEdSU1RDVExfQ1NGVFJTVA0KPg0KDQpUaGlzIG1vc3RseSBoYXBwZW4gaWYgUEhZ
IG5vdCBpbml0aWFsaXplZCBjb3JyZWN0bHkuDQoNCj5UaGUgVVNCIHNuaWZmZXIgc2hvd3Mgbm90
aGluZyBhbmQgZHVtcGluZyB0aGUgaG9zdCByZWdpc3RlcnMgaXMgc3R1Y2sgb24NCj5IQ0RNQSgw
KSByZWdpc3Rlci4NCj4NCj5Ob3RlIHRoYXQgZm9yIHNvbWUgcmVhc29uIGl0IHdvcmtzICJmaW5l
IiBvbiBQWDMwLUVWQiAodGhlcmUncyBhbm90aGVyIGlzc3VlDQo+YnV0IG5vdCByZWxhdGVkIHRv
L2ZpeGVkIGluIHRoaXMgcGF0Y2ggc2VyaWVzKS4NCj4NCj5TaW5jZSB0aGVyZSdzIG5vIGRvY3Vt
ZW50YXRpb24gYXZhaWxhYmxlIGZvciB0aGlzIElQLCB0aGlzIHBhdGNoIHNlcmllcyBpcw0KPmJh
c2ljYWxseSBqdXN0IHNsaWdodGx5IGFkYXB0ZWQgZG93bnN0cmVhbSBCU1AgdmVuZG9yIGtlcm5l
bCBwYXRjaGVzIGFuZCBJDQo+Y2Fubm90IHVuZm9ydHVuYXRlbHkgZ2l2ZSBtb3JlIGluZm9ybWF0
aW9uIHRoYW4gd2hhdCBJIGhhdmUuDQo+DQo+VGhpcyBwYXRjaCBzZXJpZXMgd2FzIHRlc3RlZCBv
biBUaGVvYnJvbWEgUmluZ25lY2sgU29NIG9uIEhhaWtvdSBkZXZraXQgYW5kDQo+UFgzMCBFVkIu
IEl0IGZpeGVzIFJpbmduZWNrIHN1cHBvcnQgYW5kIGRvZXMgbm90IGJyZWFrIFBYMzAtRVZCJ3Mu
DQo+DQo+Rm9yIHJlZmVyZW5jZSwgdGhlIGNvbnRlbnQgb2YgdGhvc2UgY29tbWl0cyBjYW4gYmUg
Zm91bmQgaW4gdGFnIGxpbnV4LTUuMTAtDQo+Z2VuLXJrcjEsIGFuZCB0aGUgZm9sbG93aW5nIGNv
bW1pdHMgaGF2ZSBiZWVuIHVzZWQ6DQo+OTY0ZDUwMDYwYmY1M2E4ZGVmZDFmYzU2MWI5MjYxNDI0
ZjI1ZGRhZA0KPmFkODFjMzc1NjAyODE5YTUzOGFkNjhkOTc5OTA2YzA1NjYzMDQ2ZTINCj42ZTZh
ZGFiOGY3MzViYzRmZTI3YTY3YmRjMzE0NGQ4ZmE4OTI1MGQ0DQo+N2MzYTRlNjAyNDdmZDdmN2Iw
NGQ5NWQxNWNiMTJjNjNhNWMyMDQwOA0KPg0KPk5vdGUgdGhhdCBSb2NrY2hpcCBrZXJuZWwgY2Fs
bGVkIGEgc2xpZ2h0bHkgZGlmZmVyZW50IGltcGxlbWVudGF0aW9uIG9mDQo+X19kd2MyX2xvd2xl
dmVsX2h3X2VuYWJsZSBpbnN0ZWFkIG9mIGR3YzJfbG93bGV2ZWxfaHdfZW5hYmxlIGJ1dCBpdCBz
ZWVtZWQNCj5tb3JlIHJpZ2h0IHRvIG1lIHRvIGNhbGwgZHdjMl9sb3dsZXZlbF9od19lbmFibGUg
YXMgZG9uZSBmb3IgdGhlIGZvcmNlZA0KPnBlcmlwaGVyYWwgbW9kZS4NCj4NCj5Ob3RlIHRoYXQg
aXQgaXMgc3RpbGwgbm90IGZsYXdsZXNzbHkgd29ya2luZyBidXQgdGhlIHN1cHBvcnQgaXMgaW1w
cm92ZWQNCj4oc29tZXdoYXQgd29ya2luZyB2cyBub3Qgd29ya2luZyBhdCBhbGwpLg0KDQpJZiAi
c3RpbGwgbm90IGZsYXdsZXNzbHkgd29ya2luZyIgbWF5YmUgcmVxdWlyZWQgZGVlcGVyIGludmVz
dGlnYXRlIGlzc3VlDQphbmQgc3VibWl0ICJmbGF3bGVzc2x5IHdvcmtpbmciIHBhdGNoLg0KDQpU
aGFua3MsDQpNaW5hcw0KDQo+DQo+VG86IE1pbmFzIEhhcnV0eXVueWFuIDxobWluYXNAc3lub3Bz
eXMuY29tPg0KPlRvOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPg0KPkNjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnDQo+Q2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj5DYzogQmluIFlhbmcgPHlhbmdiaW5Acm9jay1jaGlwcy5jb20+DQo+
U2lnbmVkLW9mZi1ieTogUXVlbnRpbiBTY2h1bHogPHF1ZW50aW4uc2NodWx6QHRoZW9icm9tYS1z
eXN0ZW1zLmNvbT4NCj4tLS0NCj5DaGFuZ2VzIGluIHYyOg0KPi0gYWRkICJzaGFkb3ciIHZhcmlh
YmxlIGZvciBIQ0Qgc2tpcF9waHlfaW5pdGlhbGl6YXRpb24gc28gdGhhdCBpdCBjYW4gYmUNCj4g
IGNvbmZpZ3VyZWQgb24gYSBwZXItcGxhdGZvcm0gYmFzaXMsDQo+LSBQYXRjaCAxIGFuZCBQYXRj
aCAyIG9mIHRoZSB2MSBhcmUgYWxyZWFkeSBpbiBsaW51eC1uZXh0IG5leHQtMjAyMjEyMTYsIHNv
DQo+cmVtb3ZlZCBmcm9tIHRoaXMgc2VyaWVzLA0KPi0gTGluayB0byB2MToNCj5odHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIyMTIwNi1kd2My
LWdhZGdldC0NCj5kdWFsLXJvbGUtdjEtMC0zNjUxNWUxMDkyY2RAdGhlb2Jyb21hLQ0KPnN5c3Rl
bXMuY29tX187ISFBNEYyUjlHX3BnIWFiRDZpMjVqMTFXdWlaeGVIZ3FTWFBMTHdwakhOTk5SMmIx
OGF3LQ0KPmxzUlVST1NfZmRuTEVuRXctdDRrb2RvVFU4cW5xWHJ6a1QyTl85dzdlNkwtcSQNCj4N
Cj4tLS0NCj5RdWVudGluIFNjaHVseiAoMik6DQo+ICAgICAgdXNiOiBkd2MyOiBhbGxvdyBwbGF0
Zm9ybXMgdG8gcHJldmVudCBjb3JlIHBoeSBpbml0aWFsaXNhdGlvbg0KPiAgICAgIHVzYjogZHdj
MjogcHJldmVudCBjb3JlIFBIWSBpbml0aWFsaXphdGlvbiBvbiBSb2NrY2hpcA0KPg0KPiBkcml2
ZXJzL3VzYi9kd2MyL2NvcmUuaCAgIHwgNiArKysrKysNCj4gZHJpdmVycy91c2IvZHdjMi9oY2Qu
YyAgICB8IDIgKysNCj4gZHJpdmVycy91c2IvZHdjMi9wYXJhbXMuYyB8IDEgKw0KPiAzIGZpbGVz
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPi0tLQ0KPmJhc2UtY29tbWl0OiBjYTM5YzRkYWE2
ZjdmNzcwYjEzMjlmZmI0NmYxZTRhNmJjYzNmMjkxDQo+Y2hhbmdlLWlkOiAyMDIyMTIwNi1kd2My
LWdhZGdldC1kdWFsLXJvbGUtYWFjNjdlNmQ0MmZkDQo+DQo+QmVzdCByZWdhcmRzLA0KPi0tDQo+
UXVlbnRpbiBTY2h1bHogPHF1ZW50aW4uc2NodWx6QHRoZW9icm9tYS1zeXN0ZW1zLmNvbT4NCg==
