Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8B96A63DE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjB1XoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjB1XoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:44:18 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8803536FC5;
        Tue, 28 Feb 2023 15:44:16 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SLCRQa018847;
        Tue, 28 Feb 2023 15:44:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=v7S4qEfRBTlZX14Big0G2P5iMgxv4zImIm3rvCWnAIg=;
 b=SiKeRSaFcegqhhG8f48nVD4GQWufbBEZz3xxh+8kXD45k1DUZKB2pZwWRMEuSs6Tkv12
 PChX8Qbtyh2IguaRDIEEg3HvNaQS8YTCZWqPhHpgiqCWNd6+v/jFViMuBKw4oS25xwOS
 pe8TdwsyoI0nm0jzRHMS2qAKGb717ITtQT+YEDhDpU4op8OKmiX20XSIjPGsMDXYRdqj
 xeCrAXyZn8CQicN2ctaISlPQ8z5ZAdnIrMWCWO1dgo9JIaXzDzFiDI1ZcQ0ihh4F6I+i
 gML2kn1/0j5yuuRMv6QG7K2Gz4WNNen221gv3I8Z81ouRGq0bsIubfCcImuY4qJk1jYe Iw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nyjfdb1m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 15:44:13 -0800
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3545B400AF;
        Tue, 28 Feb 2023 23:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677627853; bh=v7S4qEfRBTlZX14Big0G2P5iMgxv4zImIm3rvCWnAIg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GqTjpHcqI4DB0/jN1S0XoZ4Zw07dk7w02Cx8zDQQbpqwbu0B/eUWkfmVtiYuVzEXB
         vCn8v+QwJQ80F7AtiLjiqjTHZz0q+O9fVUuLH+Eh2HYUJMAhQ/rj2cO4LQhUdk2h0D
         vOI8wcBq5xTix8tm6uyfyD49SVc9PlDBSYBFUwLQXBkNV01Ov2qUvZbN7ZfITsVq+F
         kQZTp/PtnAzKHpK3o4AaXTAkKUtQla4pTKEtPlyo36BKaq/27ux24o4OEOgdsHnM0T
         Md0edkUpJCjGyTDzPPBZLiLE933IGD+L34x1Ny7qRBwbhc8qr5QI75dgIH9IjfTnUh
         Do8I5Ioi1CWNg==
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B5B9CA0070;
        Tue, 28 Feb 2023 23:44:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1EB02A0060;
        Tue, 28 Feb 2023 23:44:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="OfoWBzgW";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPF57CGgQs20NeKKDzaotBLNfBS/ZtOEjJ9nUeUuIexbWeaxXEGDaY/MEShd1JOLekQW0Mv6fFdK2fjkay76ryhHQO9G3dKP1/KB2NUmVJj6RWN9LSw/NlDaGSRtvW+QhIdP20ZfYI6HxDq8lKxll6NhqOv0bp2Xkx0aBe/Epzhj0BoJaCbC33jCox5qQioCJIk+Uawkvk5BSCguJ43VWqU/7tE4LEILYUvwIskFHVTmM58BoOW/2meDQXrtaJy9j/nlANVpb/VXovcLc9B5+bdhVQxpGcL9L00sV/N/dAmJL0TsweaephMZ1glLv8BwhHbV9zjptysYEWSlA9vSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7S4qEfRBTlZX14Big0G2P5iMgxv4zImIm3rvCWnAIg=;
 b=TTYF/WU/9BhxvkoR3hbDEPOK9dKAGv4t0+WxpDyg1HEt32XwKcNdl4R9u987+HuePSYtlcWj3/DKdatWaPv4j+vxS4etS+xcxftLoYJL1J4pEbfrpD7eZ81+Ldwhp4/NOpiHVoT86top6vc5Kv2CwvkdHeo/fXsztBpXB0/fBICueitD/n4pS27WSjdt1iG+MWp9SM9EliIXRqstivL4dh9y/Z1YzJMlGenikIvFHhdysXZnraGdA2bbHXFrLDqvo6oQ17u23nxonfdGG0a0NXp9tuWAjE2PHDLpNpNc5kyVtEvFuLWtdD0Y729bZvlzOXqwNGn+cUm7FFrSqqrysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7S4qEfRBTlZX14Big0G2P5iMgxv4zImIm3rvCWnAIg=;
 b=OfoWBzgWv31R+1QWqCs5fAF9NB10MYoc7ZAumjQHu1jvaBtHSoE2s845p2wEz4pW4edJEScBgCh8Xqh0doPGeGs7HeCg8p+AuFlcobLzT8Bj1JADCI1juMMvyGzdL3ot1kywYv9Nk4U5w7E6cZ/JumIey2QYJ6vLrhkjT/wPyfE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 23:44:07 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 23:44:07 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Add 1ms delay after end transfer
 command without IOC
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Add 1ms delay after end transfer
 command without IOC
Thread-Index: AQHZS7KwrAW/39yt4ky5Z3r/ljRbmK7lBa8A
Date:   Tue, 28 Feb 2023 23:44:06 +0000
Message-ID: <20230228234404.b6uvjpt63iz7cxkx@synopsys.com>
References: <20230228202418.9126-1-quic_wcheng@quicinc.com>
In-Reply-To: <20230228202418.9126-1-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN2PR12MB4109:EE_
x-ms-office365-filtering-correlation-id: f34d41fb-726b-459f-b4f7-08db19e5ae7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7XmLurTDtnfUbBIiCtge9z0E3udcPAgj5hFrHVvjcv+kFnmluS8eT4YbsDu8aaTY3fKcyrHnM5rUmDUClhXTezHRi3Lr1+iKw5VnbzRl8okpc91GGCC3yP0lQ2a3vVkrrwAyJahMmeFaQlvM3AHDcgdV58Y+A92UQ1aSbda/oOfB7BHgKj2KOuDgNsfOu4ZIVgjx96r4AagGUDMCeQAsS72FGumXZPaDOl/URKi2qYTVJHQQnxdY5HuFYEC+NsP4w+0UgGkwg3mwywaYrSs0+xVrJbK8JN3CVF5tIwtzq1Ruhkg9zUMfAZyEM4eTuY2F8qCJZzDKWtzcb0Gwe1+n5osMB3pauaSZpHkKQ/S/XjY0ExPpYOK68WZv36evEjLo6akmVtfqGC4RiuMG3r9tJ87LxFq/dkdhqD3c3Xll3kJdkEt1e3LQ81NO2ytft1b3W20EGswUjKZ2QprB1gPLsu/4RVLch/33dsH33eNptC7KaAId9CNmhHLlzxTRpW1adFlP1gDEn2RdgyqX3doKcWH/dRVPLc9W8mcTKJseVZZ38C2Lsrf5SiLTgSvP1JDFnIRLxghU5ihnpxDC3a/Zl2GpanA/bF1dFr+fMmwDKRcc1GajJi5Z8z1JgJ+VJmQcthm8sP69x7FVv67k9EnljkKoUqaFkFt0+ol0MSPNHIRtMM26+taHmK3686CYbUazOTlG/cMZKR3AGh1RaatFsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199018)(83380400001)(36756003)(6506007)(316002)(54906003)(478600001)(38070700005)(122000001)(2616005)(26005)(41300700001)(186003)(71200400001)(1076003)(6486002)(6512007)(38100700002)(8936002)(2906002)(86362001)(5660300002)(66476007)(66446008)(76116006)(66556008)(66946007)(8676002)(6916009)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T05uWXpZaGgxWmJVRTZ5ZWxLdGx6NkdEcitvNEJkaFk3VmtXZDdLTkMvNEZV?=
 =?utf-8?B?VTRzcGFlOGh4MnhhbG5xdkZWakVVUHh5VkJpRnlvc2hpQ2h2Nzc5OUFxOXFv?=
 =?utf-8?B?d045TWhyYWhlMkhHR0JreFJmQWNSRDE4YXU5MmI1bjZnb01DdGxmYjJKRWUw?=
 =?utf-8?B?M05tQTh5MU5XdTFVb2VFQzQ5Q3oxRmphbmJuTHVadmxzMSsyOUhkaEQ0b3RP?=
 =?utf-8?B?N0NBYmZjMWZtZTMrRi9CbWFGdzhDVEFYbWJuL2UrMDhGYUd0N2hsV0tBK2tB?=
 =?utf-8?B?OStyZFNSK1I3K0c3T1lVSGlGUEJkdUZEOVB1dm1nZkxMRTQvSzkrN0xRNDRz?=
 =?utf-8?B?NFoyUnE2TlN2SDlTKzE2cVJqekNTUXI1V1NrTitpOUFaN21DZmEvTmNaMVZ6?=
 =?utf-8?B?ZldFOSt1bld2R1VYK1RlelRRT1VXb2d4dHlxb2RyRytwVG9rQ25FTkJGMEE4?=
 =?utf-8?B?U2pMUFM5ejFwWXFpRG9jQmVydG51eGd3T0pCNjNFYnVwZklzMW9qRmxCaGRk?=
 =?utf-8?B?YWxQc3E5R2NvZzlXekptMUp5ZHI5VlhheEwwdTc2RXo5VzRyMTk0b2szU3d5?=
 =?utf-8?B?cm5lM2JEc3lGN1N2SVFtcFRkb1Zsc20xQUt4UkkwMHR2ODlJRldPZU9aenRO?=
 =?utf-8?B?OE94ZWdqUG0vdEJoK1FzNCtZemV6Qmo4Z0VGM2xNUTk0VnFvSFNUVlRXVGhS?=
 =?utf-8?B?NEVhTVVhcGx5cUh6Sjdlbi84SlhmV2U0ak5sejZicldxWlkyUkhOYUFDRnVN?=
 =?utf-8?B?N1dKUE91YklUM3dDWTdaQnphOXNzMHg0cW9xNXZsQSs4YXZRNDJ4U0cxSVV5?=
 =?utf-8?B?Z1VQL2gyTlgvOGVDQzlFT1d2TGdQNkhRVm9LanhXY2hJTkhFMUdMeVRUL0ZZ?=
 =?utf-8?B?ZmdNSmk5d0tTRlUwK2UrYVBDalVYZlNaWml5Ui95bHpEVXZQRk5HdEU4SUt0?=
 =?utf-8?B?RVpkQy9nc0ZnMDIrTkpPaGNMb3BNclRaeEZGNWRTcVJMc0lJQmtvby9pMkNK?=
 =?utf-8?B?Y3NseDJuMDZGWXV4TXN0NFhJRWhNdk9xWTUzSWM3VEFOVmRtSHJsQzFMdERM?=
 =?utf-8?B?dDkxOThTVGpHVTFocUw1ZFpCTS9IOWJvc0xmMDFjaml3dXFyVldPUWJpNU9F?=
 =?utf-8?B?L0JxU0l6K01BSmhjbFpEYlVkL2pnd21LSlJqQ1JpWWxNMkE3RzBCM0kyTjB0?=
 =?utf-8?B?TGcycS9odjhRNjlHUkhIVVFsUEw1SGd1R0ZzWVNRdjRmbGIxbHRXblpzSFVn?=
 =?utf-8?B?Y3dpL1NraVJUdHQ0R251YnFrQkhyak9DeVhRR2RaWWw0Z2JFZHkrU0htRVk5?=
 =?utf-8?B?OGxlVGVTVHJPdUpqZTN0TzJ1Znh0NmJLWkR2ZVZpRUU5MkVYNWx5STcwdHE0?=
 =?utf-8?B?SUx6RklYZmxqN3lZRXN1OHljRGlLQ1dMVitKN3Z3YlN5UnFCT0xMLzlwUHI4?=
 =?utf-8?B?TnpvZ2pWZ3IzYjBrejUxd20yY0JrWjNTZ1NVN2FYOU9yL1o2bXJJVE5HZ2o2?=
 =?utf-8?B?L29YdVRTNnpEUTUydTRRcWk1L3NubnZQTTRsdU02Ly81SmdWdGlkZWdWUG96?=
 =?utf-8?B?Szg0Q1FlVGgvS2dZZmdQRktwMXQwemFYTzVOK2E0dmlJNXk1U2xOMml1VUQv?=
 =?utf-8?B?anBnZHFUOWFqU1h2eUorNnF4K2o3cWh1Y1M3VUNCdmdicFRreTUrYUJTT1Ra?=
 =?utf-8?B?SkV2NFpwKzl6OHRXOXRPMzM3bDVMaUIzS3cwT0ZVUlRVYSs5SzkyZnJZZUR0?=
 =?utf-8?B?Qm1KTmZZOHNQNlVBaTRCK2VpWVZEaVN6R2RleTJISFZmNzJ2QTJiaWxYZlVZ?=
 =?utf-8?B?UjYvZU0yM0hxV1MybERmMzQwc2ZoZnBwNXlBZnU2YnMzU1k2TSt3bEpTeHU4?=
 =?utf-8?B?Vjh1RFhDa3llN2psYk5WRWhPbzlUQThGUlBXU0ZrRHl0UmwxSHlBanIxbWRa?=
 =?utf-8?B?YTNoY3BrRnZmcGY0RkcwaitIVVpobi9mMzFxbUVGYVNVbGthRzlwUERUMThv?=
 =?utf-8?B?dFJWSXhNYityTUpaZGxOMm03SU9Yb2ZOamRxMlkzc1FvSWY3VDg5a3ZuTjBx?=
 =?utf-8?B?WFYyakpJSmxVSys3bklMNzd5V1BJNjd4Vk1POERxaXpNSW5XMlIyVVhxcVNw?=
 =?utf-8?B?bGpxQ3NWcWd6OU5KWTFVT0JwQWZ1T25xL1plMHg3b2hmY25CUFp4VUc2MWwx?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3B78E7081D2B545B3D63F2E1406D1C0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Yc+nwrDwQHi/7RnKmsSt48/9h+2vKpkiBXXp3b2mhPwpiGLqM+3+aT5PiRNHjtCpA9KJyQPtlw8XlMsSIxQX9I/2IwQG7XuRyRl3MAFv9dduGg+noihCuGc4LPx6YlrXjXCXhLkr+6gtNMflzQWF0+N6xBT8kbRHrxz99c6amY3DjDd0EHzK2RZSxUGu9owDY0kMZmATNGHs5JYWKj3LKZQQkJodHaDpB3FAK3fhImTpfUwbz+u7bxmQFPAlLn02hMZguvc2Lg0/G4c+ku7MJlZlhwCaKx+b+040g75Cf8BsV4aRI5RhHmRALGRDHSyWnaqWhS0mfgmcxg8LHBq6fM+DIzZc4hc0D57I2zVeLA/LmKIXYAr1IJhNY99BBjMMeM1zYrnFA25dd3BPqlFZEgoHhl4lAItrqlnlNb4oyM7TEyeX84bRYEf4+daaO6fgjJPlQmK2EOzMOvKk6uuWEYlXTauqTk6xJdp+Q5IT4YllEJhOQEpevT4X45d1YIsXEQEjp3usuvoWCzo/rESLI50H3FT1Tke/xH9fFMMWbIYZEjSUsEEbOMgHEcxj0Zy2C70Zw2YJcIVXXk7uCkrQp9Ia/xSd3n+WKHkfK4ioepeBZg3IZuAg1cQt4m6uWasgNA7v3THphU/N3KG8sEiAQ1hixP79j9jDYoEFqLlUjKUM3oIbYCCLhd+W0icAsfmCiPCIAdbZ830mxrhGbVgLpagqZdm6UBQWVvQiSuQI6dFvA+hbvcVMO4Oxu1t3jnco2a5eNFMUc1NuLceh7zvyx0/FVDjpTnHy8QMBTTA23QnDyZhxGDAqjynf6o9RC2OJnylkHP3oxVfiUSofQzcnlTesqd2t4x0VK+Hsrf1/Dm0h3LP/6nUGnF6QFEoTL9vDrp0Emp/Qjfgyr4o8GEvSwg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34d41fb-726b-459f-b4f7-08db19e5ae7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 23:44:06.8227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNRywFfbigch6EN0GGYsLu8/yhY0w8mJIsMA+eU2CfSaM4xQdtpESQflPNqzgLXiYWp9RiIbGGoZ/meUleMKsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
X-Proofpoint-GUID: Yf3w322ixP-5yerWjGT3NS8VgN72Ron0
X-Proofpoint-ORIG-GUID: Yf3w322ixP-5yerWjGT3NS8VgN72Ron0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=658
 impostorscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBGZWIgMjgsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gUHJldmlvdXNseSwg
dGhlcmUgd2FzIGEgMTAwdVMgZGVsYXkgaW5zZXJ0ZWQgYWZ0ZXIgaXNzdWluZyBhbiBlbmQgdHJh
bnNmZXINCj4gY29tbWFuZCBmb3Igc3BlY2lmaWMgY29udHJvbGxlciByZXZpc2lvbnMuICBUaGlz
IHdhcyBkdWUgdG8gdGhlIGZhY3QgdGhhdA0KPiB0aGVyZSB3YXMgYSBHVUNUTDIgYml0IGZpZWxk
IHdoaWNoIGVuYWJsZWQgc3luY2hyb25vdXMgY29tcGxldGlvbiBvZiB0aGUNCj4gZW5kIHRyYW5z
ZmVyIGNvbW1hbmQgb25jZSB0aGUgQ01EQUNUIGJpdCB3YXMgY2xlYXJlZCBpbiB0aGUgREVQQ01E
DQo+IHJlZ2lzdGVyLiAgU2luY2UgdGhpcyBiaXQgZG9lcyBub3QgZXhpc3QgZm9yIGFsbCBjb250
cm9sbGVyIHJldmlzaW9ucywgYWRkDQo+IHRoZSBkZWxheSBiYWNrIGluLCBhbmQgaW5jcmVhc2Ug
dGhlIGR1cmF0aW9uIHRvIDFtcyBmb3IgdGhlIGNvbnRyb2xsZXIgdG8NCj4gY29tcGxldGUgdGhl
IGNvbW1hbmQuDQo+IA0KPiBBbiBpc3N1ZSB3YXMgc2VlbiB3aGVyZSB0aGUgVVNCIHJlcXVlc3Qg
YnVmZmVyIHdhcyB1bm1hcHBlZCB3aGlsZSB0aGUgRFdDMw0KPiBjb250cm9sbGVyIHdhcyBzdGls
bCBhY2Nlc3NpbmcgdGhlIFRSQi4gIEhvd2V2ZXIsIGl0IHdhcyBjb25maXJtZWQgdGhhdCB0aGUN
Cj4gZW5kIHRyYW5zZmVyIGNvbW1hbmQgd2FzIHN1Y2Nlc3NmdWxseSBzdWJtaXR0ZWQuIChubyBl
bmQgdHJhbnNmZXIgdGltZW91dCkNCj4gSW4gc2l0dWF0aW9ucywgc3VjaCBhcyBkd2MzX2dhZGdl
dF9zb2Z0X2Rpc2Nvbm5lY3QoKSBhbmQNCj4gX19kd2MzX2dhZGdldF9lcF9kaXNhYmxlKCksIHRo
ZSBkd2MzX3JlbW92ZV9yZXF1ZXN0KCkgaXMgdXRpbGl6ZWQsIHdoaWNoDQo+IHdpbGwgaXNzdWUg
dGhlIGVuZCB0cmFuc2ZlciBjb21tYW5kLCBhbmQgZm9sbG93IHVwIHdpdGgNCj4gZHdjM19nYWRn
ZXRfZ2l2ZWJhY2soKS4gIEF0IGxlYXN0IGZvciB0aGUgVVNCIGVwIGRpc2FibGUgcGF0aCwgaXQg
aXMNCj4gcmVxdWlyZWQgZm9yIGFueSBwZW5kaW5nIGFuZCBzdGFydGVkIHJlcXVlc3RzIHRvIGJl
IGNvbXBsZXRlZCBhbmQgcmV0dXJuZWQNCj4gdG8gdGhlIGZ1bmN0aW9uIGRyaXZlciBpbiB0aGUg
c2FtZSBjb250ZXh0IG9mIHRoZSBkaXNhYmxlIGNhbGwuICBXaXRob3V0DQo+IHRoZSBHVUNUTDIg
Yml0LCBpdCBpcyBub3QgZW5zdXJlZCB0aGF0IHRoZSBlbmQgdHJhbnNmZXIgaXMgY29tcGxldGVk
IGJlZm9yZQ0KPiB0aGUgYnVmZmVycyBhcmUgdW5tYXBwZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBXZXNsZXkgQ2hlbmcgPHF1aWNfd2NoZW5nQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gQ2hhbmdl
cyBpbiB2MzoNCj4gLSBGaXhlZCBzdWJqZWN0IHRpdGxlIGFuZCBtb2RpZmllZCBjb21taXQgdGV4
dCB0byByZWZlcmVuY2UgdGhlIG5ldyAxbXMNCj4gZGVsYXkNCj4gDQo+IENoYW5nZXMgaW4gdjI6
DQo+IC0gSW5jcmVhc2UgZGVsYXkgdmFsdWUgdG8gMW1zDQo+IC0gTWFrZSB0aGlzIGFwcGxpY2Fi
bGUgdG8gRFdDMzIgcmV2aXNpb25zIGFzIHdlbGwNCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jIHwgMTUgKysrKysrKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCAzYzYzZmE5
N2E2ODAuLjE1YWRmMDdhNGRmNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0xNjk5LDYgKzE2
OTksNyBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfZ2V0X2ZyYW1lKHN0cnVjdCBkd2MzICpk
d2MpDQo+ICAgKi8NCj4gIHN0YXRpYyBpbnQgX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKHN0
cnVjdCBkd2MzX2VwICpkZXAsIGJvb2wgZm9yY2UsIGJvb2wgaW50ZXJydXB0KQ0KPiAgew0KPiAr
CXN0cnVjdCBkd2MzICpkd2MgPSBkZXAtPmR3YzsNCj4gIAlzdHJ1Y3QgZHdjM19nYWRnZXRfZXBf
Y21kX3BhcmFtcyBwYXJhbXM7DQo+ICAJdTMyIGNtZDsNCj4gIAlpbnQgcmV0Ow0KPiBAQCAtMTcy
MiwxMCArMTcyMywxNCBAQCBzdGF0aWMgaW50IF9fZHdjM19zdG9wX2FjdGl2ZV90cmFuc2Zlcihz
dHJ1Y3QgZHdjM19lcCAqZGVwLCBib29sIGZvcmNlLCBib29sIGludA0KPiAgCVdBUk5fT05fT05D
RShyZXQpOw0KPiAgCWRlcC0+cmVzb3VyY2VfaW5kZXggPSAwOw0KPiAgDQo+IC0JaWYgKCFpbnRl
cnJ1cHQpDQo+ICsJaWYgKCFpbnRlcnJ1cHQpIHsNCj4gKwkJaWYgKERXQzNfSVBfSVMoRFdDMzIp
IHx8IERXQzNfSVBfSVMoRFdDMzEpIHx8DQo+ICsJCQlEV0MzX1ZFUl9JU19QUklPUihEV0MzLCAz
MTBBKSkNCj4gKwkJCW1kZWxheSgxKTsNCj4gIAkJZGVwLT5mbGFncyAmPSB+RFdDM19FUF9UUkFO
U0ZFUl9TVEFSVEVEOw0KPiAtCWVsc2UgaWYgKCFyZXQpDQo+ICsJfSBlbHNlIGlmICghcmV0KSB7
DQo+ICAJCWRlcC0+ZmxhZ3MgfD0gRFdDM19FUF9FTkRfVFJBTlNGRVJfUEVORElORzsNCj4gKwl9
DQo+ICANCj4gIAlkZXAtPmZsYWdzICY9IH5EV0MzX0VQX0RFTEFZX1NUT1A7DQo+ICAJcmV0dXJu
IHJldDsNCj4gQEAgLTM3NzQsNyArMzc3OSwxMSBAQCB2b2lkIGR3YzNfc3RvcF9hY3RpdmVfdHJh
bnNmZXIoc3RydWN0IGR3YzNfZXAgKmRlcCwgYm9vbCBmb3JjZSwNCj4gIAkgKiBlbmFibGVkLCB0
aGUgRW5kVHJhbnNmZXIgY29tbWFuZCB3aWxsIGhhdmUgY29tcGxldGVkIHVwb24NCj4gIAkgKiBy
ZXR1cm5pbmcgZnJvbSB0aGlzIGZ1bmN0aW9uLg0KPiAgCSAqDQo+IC0JICogVGhpcyBtb2RlIGlz
IE5PVCBhdmFpbGFibGUgb24gdGhlIERXQ191c2IzMSBJUC4NCj4gKwkgKiBUaGlzIG1vZGUgaXMg
Tk9UIGF2YWlsYWJsZSBvbiB0aGUgRFdDX3VzYjMxIElQLiAgSW4gdGhpcw0KPiArCSAqIGNhc2Us
IGlmIHRoZSBJT0MgYml0IGlzIG5vdCBzZXQsIHRoZW4gZGVsYXkgYnkgMTAwdVMNCg0KMTAwdXMg
LT4gMW1zDQoNCj4gKwkgKiBhZnRlciBpc3N1aW5nIHRoZSBFbmRUcmFuc2ZlciBjb21tYW5kLiAg
VGhpcyBhbGxvd3MgZm9yIHRoZQ0KPiArCSAqIGNvbnRyb2xsZXIgdG8gaGFuZGxlIHRoZSBjb21t
YW5kIGNvbXBsZXRlbHkgYmVmb3JlIERXQzMNCj4gKwkgKiByZW1vdmUgcmVxdWVzdHMgYXR0ZW1w
dHMgdG8gdW5tYXAgVVNCIHJlcXVlc3QgYnVmZmVycy4NCj4gIAkgKi8NCj4gIA0KPiAgCV9fZHdj
M19zdG9wX2FjdGl2ZV90cmFuc2ZlcihkZXAsIGZvcmNlLCBpbnRlcnJ1cHQpOw0KDQpCUiwNClRo
aW5o
