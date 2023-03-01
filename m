Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A383B6A6BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCALaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCALa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:30:27 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0AB1C58F;
        Wed,  1 Mar 2023 03:30:26 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321950Qr018838;
        Wed, 1 Mar 2023 03:30:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=5XtbDpT0+iQqa5owS57OmpiMfbeWS63YjBd9s6+7Ep0=;
 b=UaksEQFylP2wessvev4Wk903gwH+1V3GXvtcEoZOUPYMU3n9++RXRFclVJ8EVSCQQbvF
 N9fwCK1ylsoEdKArzeVldD60ooamWAz6M2fFsPRZxzzB3YmcebzNB80wGyN5zCGIQVPp
 i/RH0o9CHoM/i5WAWUPhVOYTPkcZdbrc0uOdjzF/Ll5wyOyKCPahQSkw/UMSvNM5gKQp
 IHffp/7O2gUBolKuBI1wEwgLj/1QQaVkns0Xjo+12d6qI+LPm9Dd2tIA6mX2e/TGu+os
 znV4RKpXQGA4qdfmEUzSZi9R5uBR/ys7samOo7KaJqpOi7OBvX+RaduLut+pLGv1a5Os 7Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nyjfdg40p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 03:30:17 -0800
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0BDA3C05B0;
        Wed,  1 Mar 2023 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677670217; bh=5XtbDpT0+iQqa5owS57OmpiMfbeWS63YjBd9s6+7Ep0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QpNV7+OLXGC/TfjKMed/nYw6773Udzmqfc00p4ZN3sapUKLI7DMozMmTBVL/25lFP
         OwILDE7b3VYeVNjkXZ5omUkAEyDCqYihvDaD9esIwssDDMXPgLm5W+CD1170IxhYjM
         BBRxREp3kcaTi11hfG1cJp9ExmnUBl+72jKgKHDOMEIVJxjwsfQxbt5NJJrwchYrY1
         C570znjSpEnV0ySjdZPikx0VSYhNdQHaZYZsiFheixx5M5h69EiHeVAeNvZzEG1QpS
         MpI3QVBnU9x6I+Tkj0FqBv2KKurXalQgFzaAgzLH5dwA2BdPIUVvuW7FGUGLolXhdU
         g6rbtV/XVGkkQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id ED5E0A0076;
        Wed,  1 Mar 2023 11:30:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 74FFD800FC;
        Wed,  1 Mar 2023 11:30:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="UeSx3JXJ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBkkWgPA07sMGwdNI0xExmPJ2RRRVWjX2avE9fNt/ozRokOQgSmOVfNQ7DUVJy8uBmEtdDL8iQLMGRyFF5Jp/H9SscvduMoT93L5B+0Y9Ycyby88DQsqc9vcYkj3oBdvIs0Eu4u4dARS29+GmK7AU1nsVvB/AtIguOuGfRnl8bVuSG/S2vCKbP1A5H8AqmrrjRIlhK7KbckqIge7JBP43akG0x5Kvh0rIqO6gR7DmOuwIJC7wKfLk2fF3BzLIZcHudeGysb2YcCHUFl7dlP46kOHMFBaddjNnVCdQ1TYJRGnQ++xd9Y9M8cRiiI6PNkLlSOgSJkQdR4kiXn25uwURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XtbDpT0+iQqa5owS57OmpiMfbeWS63YjBd9s6+7Ep0=;
 b=kWfk9CfuSD+Xp2VIhErvVO/WA9n6hth2IZ4fKTgQWBAbl2RHH4KLu4ZDKHBNeCpWfVKw1nSb96DLPicY/zuyGanjMRRx9FH8IFsHKL6yzPEDJ/B///aT6zszHLSjmUAT/wsn/Gz1zVjDAdehiwVsPTSu3iSL+/mpKMCmY3rWlj+Vy2ylcvDpVzVyawbsJS+hujCCOxWj/5uTMiRo68IG89iOB9TjbggMk6zfVEXniJbuId/z/U1+8eZSRpl78HAdDCpGCy0mKuF/dQn27EwjUJL+OwImsAyE4V8j1aDtRmkFVVYLcHYggIt8vUmEn6IZvMyojbmF3dBqoNEIQuh0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XtbDpT0+iQqa5owS57OmpiMfbeWS63YjBd9s6+7Ep0=;
 b=UeSx3JXJUev/1mGhDg5bZHYfsX52PEO53WM2aj4DiH/bP9sKfTEx68YQD2wAyitQVytZHHx17RCte048ydCD6ZQQX6gUQRrcbQ15eajPfKEJ3oU9fXZRJMpR6bHvQn2kEI/yBiU4kWaRS0XHKNul5C9IZJ10YEITCrJ1uIISveI=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 11:30:11 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::b864:207b:e50f:2ffe]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::b864:207b:e50f:2ffe%5]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 11:30:10 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Ziyang Huang <hzyitc@outlook.com>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if
 role-switch-default-mode="host"
Thread-Topic: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if
 role-switch-default-mode="host"
Thread-Index: AQHZRd+knSYE4gin9E6iCq3Lba7rya7aiagggAtL0ACAAADlsA==
Date:   Wed, 1 Mar 2023 11:30:10 +0000
Message-ID: <BYAPR12MB3399694BFBFF1FC699757178A7AD9@BYAPR12MB3399.namprd12.prod.outlook.com>
References: <SG2PR01MB204837BF68EDB0E343D2A375C9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
 <BYAPR12MB33996D70422B24DE982F3B4AA7AA9@BYAPR12MB3399.namprd12.prod.outlook.com>
 <0ffed85a-6bc9-b51e-c431-a23b9bf3919c@foss.st.com>
In-Reply-To: <0ffed85a-6bc9-b51e-c431-a23b9bf3919c@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYUcxcGJtRnpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RObUUzTVRnMU4yVXRZamd5TkMweE1XVmtMV0l3Tm1NdE5XTTFaalkz?=
 =?utf-8?B?Tmpka05EaGlYR0Z0WlMxMFpYTjBYRFpoTnpFNE5UZ3dMV0k0TWpRdE1URmxa?=
 =?utf-8?B?QzFpTURaakxUVmpOV1kyTnpZM1pEUTRZbUp2WkhrdWRIaDBJaUJ6ZWowaU1U?=
 =?utf-8?B?QTVNeUlnZEQwaU1UTXpNakl4TkRNNE1EY3lOalk0TURZMElpQm9QU0k0ZWs0?=
 =?utf-8?B?dmJIcEtaRWhyTlhsaVdDc3lOVXBYVG5wUVVUazNhREE5SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGSVdVbEJRVU5uZGpocmMwMVZlbHBCWW05T1FqUlVPRFIzWVRWMVp6?=
 =?utf-8?B?QklhRkI2YWtKeWEwNUJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
 =?utf-8?Q?FBQUFB?=
x-dg-rorf: true
x-dg-refone: =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVGQlowRkJRVUZCUVc1blFVRkJSMWxC?=
 =?utf-8?B?WW5kQ01VRkhORUZhUVVKNVFVaHJRVmgzUW5kQlIwVkJZMmRDTUVGSE5FRmFV?=
 =?utf-8?B?VUo1UVVoTlFWaDNRbnBCU0ZGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJRVUZCUVVGQlFVRkJRMEZCUVVGQlFV?=
 =?utf-8?B?TmxRVUZCUVZwblFuWkJTRlZCWW1kQ2EwRklTVUZsVVVKbVFVaEJRVmxSUW5s?=
 =?utf-8?B?QlNGRkJZbWRDYkVGSVNVRmpkMEptUVVoUlFXTjNRblJCUjAxQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZDUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVsQlFVRkJRVUZLTkVGQlFVSnRRVWM0UVdSUlFuVkJSMUZCWTJkQ05VRkdP?=
 =?utf-8?B?RUZqUVVKb1FVaEpRV1JCUW5WQlIxVkJZMmRDZWtGR09FRmtVVUowUVVkTlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlJV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJtZEJRVUZIWTBGa1FVSjZRVVk0UVdO?=
 =?utf-8?B?QlFubEJSemhCV2tGQ01VRkhUVUZrUVVKbVFVaFJRV05uUW1oQlIydEJZbWRD?=
 =?utf-8?B?Y0VGSE5FRmFkMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQlkzZENh?=
 =?utf-8?B?RUZIZDBGYVVVSjZRVVk0UVZsUlFtcEJSMDFCWW5kQ01VRkhORUZrUVVKbVFV?=
 =?utf-8?B?aEJRV0pCUW1oQlJ6UkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-reftwo: =?utf-8?B?UVVGQlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bnBCUjBWQllrRkNiRUZJVFVGWWQwSjRRVWhWUVdKM1FqQkJSMVZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVoTlFXSm5RbmRCU0UxQldIZENjMEZIYTBGWmQwSnNRVWMw?=
 =?utf-8?B?UVdOM1FteEJSamhCWkVGQ2JFRklTVUZpVVVKbVFVUkZRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRmpkMEoxUVVoQlFXTjNRbVpCUjNkQllW?=
 =?utf-8?B?RkNha0ZIVlVGaVowSjZRVWRWUVZoM1FqQkJSMVZCWTJkQ2RFRkdPRUZqZDBJ?=
 =?utf-8?B?d1FVaFZRVnBCUW14QlJ6UkJaRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlNqUkJRVUZDTWtGSFkwRllkMEp5?=
 =?utf-8?B?UVVkVlFXVlJRak5CUnpoQlkyZENhMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBGQlFVRkJRU0l2UGp3dmJX?=
 =?utf-8?Q?V0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|MN0PR12MB5930:EE_
x-ms-office365-filtering-correlation-id: 10fbc40a-79c3-43d4-b461-08db1a48512e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w2Am1Hs65mG9zxFtxaS8GdDbPFhpnLCJC0oI0ZoTCGh4ZW+FY7szj5ho+8idW/tHP/YZsQy619ubwCmuhhZVO20RwayYBw4hMeBxjYF9wXLvquqYxQvR2q6xeVsHyB/H63FKplqcit0lr+Jd+1JUi61i6mQO9sBPPwG4P6cF77d08MByrYvs0l/nUT/lUUiT0nZvJoesCYoB1CSHgYQzYCEuXx32lXEcmDOrgiNtgfi2AhqXlehuFSTJDEjKWvF3OsX/gADz3hvSxMTu8GDYpaG5RuFATVuyeJaABv25vKkAf+cdMjTibDPvX2DF9pSTPRMV0lzQ2FCuiBWUlvoaTzJ+NuryXKE21abjEIXfpnxl7AVfoEzZd2+RGZl2wsdwhtOIw8IQhmv6gFY/epuTQ5LgvHdK8HrAa5yV+LBtHdrXIf4H8dHLXZdevdwO3Jk8ymyLD1VRaQukRSTv17iMa5L6iGKjWwethX1zPa4pZuNnzj2k42Ytfe/3PNccAhBAAawNcfLRGM8KIGJ28kZM/0jWlFHJPCS4SUTJT7/9nTC6rylVXMKOGgwyGRLJ4mMIJnxQIJUdYQtgInHT7GnO1XBmuOuFW8RoCAcX0q/pRo6ro+nBNCxF6SGPw7jWcYlAs8nT503yfnA2BkPrZG7i+azUf4n/AkupftNBQptzOKlPRY67nJ07AeF0PsiWs+dk/5EifNO8bXPOAzepPUG8DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199018)(33656002)(38070700005)(86362001)(52536014)(64756008)(66446008)(66556008)(66476007)(66946007)(5660300002)(8676002)(4326008)(8936002)(41300700001)(55016003)(4744005)(2906002)(122000001)(38100700002)(71200400001)(7696005)(478600001)(54906003)(316002)(110136005)(83380400001)(26005)(76116006)(9686003)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0g1bzRUWnIwNHNieXdwMldHWTljQkR3SDVXalRJcWluQkh3TC82RkVJL0Q1?=
 =?utf-8?B?emU0RUNIK0xsZUxjV0IyUmI3Vjh4WjFjOHMwWUhwclNSOUEzbzFhSDBHdE1y?=
 =?utf-8?B?Z0NPWnF0a2trZGJJVnM5SHd1T2tXTjB2Skxpcy9yVDBQWjhEdFBYaVNMMTJk?=
 =?utf-8?B?blgyZTVnTTl2NTJHa1hUdHN3QkRLRUwxNDR6RVB6NEtRaXQ0S25iUUY1WTM3?=
 =?utf-8?B?a3BMcGRlNVhnMzFGalZoanlVMXUwV25aRUtRdStGMHBPWjBLNkFsdzFNaFhH?=
 =?utf-8?B?bnNXZW9oek5oZUNJSldobjZadW11bzYwVHNmS3U0OVA0SzlhQVRUWWRtcC9m?=
 =?utf-8?B?N29hN3pqQmtwZkg2THFVa0hVL2svMnpzd3VydFZwbHFISHFqUnRZbkZieGRw?=
 =?utf-8?B?V09FcllSZ3p5TFRCZ2hXTm1jVG5Hc2JlMExoQkR1a3VQYzBJdkhPdXVEU1N1?=
 =?utf-8?B?djlkUFlONllVUDdJVW05MzV2d2YvcHRsM1AyblJCS3dsMEFSeXFDTXJRQjNK?=
 =?utf-8?B?cUxscVNydkdObTAxbnlwbzNPVkJnYjFtVE5obDhKbGZHRUlJTk9JZ3RHR3hl?=
 =?utf-8?B?aU10Zkp2VzFsK3VQZ2xZVGgwK09ia2pjd0pDUjEvZ3NpOEo2ZzNadFdpWHhh?=
 =?utf-8?B?UGh5eUJGeVg4QU02SXhwZ0tXdEhPMEg5TmNkTWc5WnErU3VVYzhmK2R5d3FW?=
 =?utf-8?B?cDNDcytsOXlrVFIwcFJJa3BMQVhIZE1hQzU4TG85Q09RMjhQdVl4K016cTFX?=
 =?utf-8?B?d05XLzRYMFNlUjBNTmhtTExoTTJiWFlTTUVweEJodW5aeXhJemJjbEl1TWxD?=
 =?utf-8?B?MGJZSWlNUUVtTWdXRnFnMzF2cDdIMWlDNlhZdmxqTW9obXJMUUJKTU8yUDF2?=
 =?utf-8?B?VGNWSVhBZnordHdnNWRTVC9mZUtnWmFuTS8zZHdnUVJtNXc1dzNpS1ZzU2pL?=
 =?utf-8?B?R0pDQTBQeStRL0tjWlpUUXlnb2ZrTklJUkd5bGduTER6dko5bVlmVDZmVEQx?=
 =?utf-8?B?THB1WDdjeEtoYzM0MVpEL1Q2Yis3dTRTRTRPZnBLSFNqV1JoM3JkaUNMY2xW?=
 =?utf-8?B?OWdWKzhDQS9kTlpVZkh5Y3dRcU5RU1BVaGpYbTBJdEt2cGsvU1VNbGs4ME85?=
 =?utf-8?B?UFJYT2FiOFd5SEhWb1BuVWYwekQwTy9qS0R4WDZOY05mOWkxK29qMURMZXZn?=
 =?utf-8?B?WGJlZ3pmVlppVHZ1ZU9TbmRjSzhiYm1INC83aFdILzZOdm1pbXBOL1FjZENQ?=
 =?utf-8?B?V1Z3MUxqTDlvMVhCR1pUTFZETzhWYUpSVWcyM1VVNGV2SkRIczZEU1EzeWl6?=
 =?utf-8?B?cTlwZDdBbUwwVEhYVkF2R3gzZFJjOWtyMlFyZjdvcy95ZjVmK2RrMjBia0NU?=
 =?utf-8?B?WGVFelI3Qko2eCtaWExCZkxzdHR4S0tDLzhRaDlNR3RBVmkzWTlwRmZQRFhJ?=
 =?utf-8?B?TjlEdUw3SlFmZWxrOVFmL1JzenNIckNYNmtleHIzaEhuL0Z6S1ZMcUd5MlBD?=
 =?utf-8?B?Q1hvakE3ZU52NktDc2pGeVZHaitTVzFWVnVLaGdVdnhPTE9nbGlGRjVJbE04?=
 =?utf-8?B?aUlTRWlPMVdUNGRVRFBNL2tIMkFld2V5UHExVitQd3A1cE16bm1Udy9PKzdO?=
 =?utf-8?B?M2JFMjh6VkFaTGliUDNQVE4zYU1mdCtCR0JJMmltQmZ6SVh5R2xqQ0YwUS96?=
 =?utf-8?B?YjJoTDlVSHBCOFV6VS9NNTRmYkVGWFYrOGtKQlBmL2owMTZoS2tNa09SbVpq?=
 =?utf-8?B?aUQwYWU3ZHdwUFZSSjd1cUNZZlJEaWxCK1JtSHBXWUNIN2RlTTdpa1hBR2Fx?=
 =?utf-8?B?MXM3b3R1bDZKeE9ha0hvNnA0QzlTRjQyVGx2Q3FxOXV0WkNZdlBtcVNxZERE?=
 =?utf-8?B?dUN6aWwxZ25rYW9hOWxxVDI4dXdYUE9ZNzA4eEp0Z3Zzd1FmYzQ5TEtLaUhJ?=
 =?utf-8?B?empIa3EvT3p3VTAxdlhPSm5zRk5mTkhaTnZWMEU0YkhJV0IrTTRXenFRU0hB?=
 =?utf-8?B?RHhma3VpREZNZUwrN3N6RnlDY3FRcUZCUzI1UjJZcTdSWDN1RmZXcjY1cnR3?=
 =?utf-8?B?Y29pQXQ5NWkxbWdEempSUURUTHE0REYzdndYK2doQm14ZWRYMmVnT1V0SmVQ?=
 =?utf-8?Q?Czphk8jWNM9wmSD8U2zVlLYdC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fKXHGRBtwoY93+39XQrc5GdicaLdTq/IHgR5fxNLzEGdnawhpRpKsf9fnphyKDFGxbiN1tsoxOdTQf6Wfzr/FoNoxmL3T+a5ShfMy3xHb74Zgu5hSoo78rxGti2vjn3WWtx4JWZQrTBDuFhIwy6ziTM39ntF7Vdy0BBI6TKvkzgJJVv5thzN7ebc4TBJnrL7xPLPiV+zgI1SMhbS5vzl8w6JrE8vmUVMjBmsM1q67QM/zDmPCsWl29Gaozg/Bux4zrAYkZ7RfxunlgA7ThysyhbCGbMYsqJEOVx2UYMfmPRz/mmaDauXMlEY0K8zhEL3PrhFXyRDxx5ZPxQRrcZPae8bZ4zLWplBevv2GTY+XoKaRrUTTFC3q+N2mSByIJHMDg9X2NFx4cEOTb5Lqv2r1om56dSFy4n/pT0RhxigGOq57jgWIUv92RmM2aZmqvnWvQR6u5YlPcpVk9cFR5CgVriGOicMHjUkp8ILLuZqWWU3fSBcPDtqjNZSxH/diLv3WRVj9d+P5qQZq66gkSK5PjkN9ejXoGfXDDPECpsZE91v8rB3Axy6cmKqKCycdh6cYXWu6iIMOhdNtChw6ZAA9jCDLrUeHzOmEuElL5eeCM9Ngw8KVIz4GcRW6bwGEZ9oIGaNhHHTVmHCYBLU/g3ES1gHVmwT5DfqgXIvBX50QiDyc8e2wCh8Ouwo2p+kU+kDocoGr0+nA2jnFXzvnftkz8+jKCJO9mrALpwrt2D3WLDnW8Dpl6ncFeM4S5x3A/MyOmiAtc5C3AGfu9z1UldiiW8iNEBlSBQIzG6QX8MwIH2z0OcOALQZf2DRAoeZazSIAlQ/ZwoYZQhc6ARSL1K/81UFr+S443Hvc41zZNsdi79arDjuICuU/BstJ/cXE19E51Vr7Yta0vNhb4jZpcOqsSL3SwOtPtgA+1j8mgPgGhQ=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fbc40a-79c3-43d4-b461-08db1a48512e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 11:30:10.4883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAtSAVOM4IGpLuzvgI/Z6GfBjdREkA0k/y1DIxc8Yr/5wMK/oz5soI4UfaNFWj6dytAeNAh4j2594JUOJETnDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
X-Proofpoint-GUID: ZtxvZlXS_GHdbNoOL6Te08mHI74mZjUR
X-Proofpoint-ORIG-GUID: ZtxvZlXS_GHdbNoOL6Te08mHI74mZjUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_07,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 clxscore=1011 malwarescore=0 adultscore=0 mlxlogscore=776
 impostorscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFicmljZSwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRmFicmlj
ZSBHYXNuaWVyIDxmYWJyaWNlLmdhc25pZXJAZm9zcy5zdC5jb20+DQo+U2VudDogV2VkbmVzZGF5
LCBNYXJjaCAxLCAyMDIzIDM6MjYgUE0NCj5UbzogTWluYXMgSGFydXR5dW55YW4gPGhtaW5hc0Bz
eW5vcHN5cy5jb20+OyBaaXlhbmcgSHVhbmcNCj48aHp5aXRjQG91dGxvb2suY29tPjsgYW1lbGll
LmRlbGF1bmF5QGZvc3Muc3QuY29tDQo+Q2M6IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBs
aW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gdXNiOiBkd2MyOiBkcmQ6IGZpeCBpbmNvbnNpc3Rl
bnQgbW9kZSBpZiByb2xlLQ0KPnN3aXRjaC1kZWZhdWx0LW1vZGU9Imhvc3QiDQo+DQo+T24gMi8y
Mi8yMyAwODowMCwgTWluYXMgSGFydXR5dW55YW4gd3JvdGU6DQo+PiBIaSBBbWVsaWUsDQo+Pg0K
Pj4gQ291bGQgeW91IHBsZWFzZSByZXZpZXcgYW5kIHRlc3QgdGhpcyBwYXRjaCBvbiB5b3VyIHNl
dHVwLg0KPj4gRG9lc24ndCBicm9rZSBhbnl0aGluZy4NCj4+DQo+DQo+SGkgTWluYXMsDQo+DQo+
SSB0ZXN0ZWQgYXQgbXkgZW5kIG9uIGJlaGFsZiBvZiBBbWVsaWUuDQo+T2YgY291cnNlIEkgbGV0
IGhlciBwb3NzaWJseSBjb21tZW50Lg0KPg0KPlRoaXMgZG9lc24ndCBicmVhayBhbnl0aGluZyBv
biBleGlzdGluZyBib2FyZHMuIEkgYWxzbyB0ZXN0ZWQgdGhlIGV4YW1wbGUNCj5kZXNjcmliZWQg
YnkgWml5YW5nIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4NCj5Zb3UgY2FuIGFkZCBteToNCj5U
ZXN0ZWQtYnk6IEZhYnJpY2UgR2FzbmllciA8ZmFicmljZS5nYXNuaWVyQGZvc3Muc3QuY29tPg0K
Pg0KPlRoYW5rcyAmIEJSLA0KPkZhYnJpY2UNCj4NCg0KVGhhbmsgeW91IHZlcnkgbXVjaC4NCg0K
TWluYXMNCg==
