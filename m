Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB190700F07
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbjELSqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjELSqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:46:51 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D64EFE;
        Fri, 12 May 2023 11:46:49 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CEvaPw006089;
        Fri, 12 May 2023 11:46:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=7RwGb4vDcVkRnBz/Li9TE5oJew3GBSG9x3hHQA8Nl5A=;
 b=YYaBnw479SQtuBAPd3xTg0ioCawZ9cBSLXQkS+w5x0Yb25tq0rVH5vKMba3nBocoUE8I
 h5l+DYe9EGe/j9Pr9EeYxRE3UaUoatEDNFpkrWnaKFMtHh4TFUp1eCR/Nvg0i7TsldrB
 gqaHosUsoAss056JkMerUnU8predA/SMY4oM6e92VcIuPQwzUQepm54TqDiOxtUbdxV6
 It2q0NiR4itEGEY49/HqBgiI05WgUf+S4KWN1qiPhzfYfly357p4knxM3LEtlIm8sgmc
 GjQrqovjRNxTYjfeRrgQy5hXhMJ8/dIToXPQGIY0sTzW6BOTqaDiAv+O+ipspv0rS2la lQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3qf772p3td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 11:46:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683917206; bh=7RwGb4vDcVkRnBz/Li9TE5oJew3GBSG9x3hHQA8Nl5A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=M8GGla14Fxq81NujeWyFcQr6ExC0IHwL+nTN4GzGWA4vcwBy6TE6xyNB+B2DCZQai
         j4OcGVBD8WtBL7wm5MgCxufseA6lSCe9avMPNQpwy4M1Z3hBRiAxQV04h7QtUClat+
         BMV/oSv/OfYp5epIULtV/mk5WBLQuRuh8AP2RFc9BbYAKnNTotdg8JbQ9p6Jm3l3AP
         bJ3G3ixxrqqrNCLHAGflJug+mTZRRdqZJozaXhUGT6xfBPs8nWWxrBbv092g/Ns3+c
         wSplfxRSNrYGTQyKucBIPkf7hrXJvdRQ9oCHzZuLCYdaZ5EqNaTQJugWfeE623ta36
         wgJvmJeRTHmRw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 38DD840636;
        Fri, 12 May 2023 18:46:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B911AA0073;
        Fri, 12 May 2023 18:46:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NyemgLcQ;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B1BAF40639;
        Fri, 12 May 2023 18:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/o2fe+yeO0kT0F6VsRNSV9zYJ0kQfaVrxqlGTbHWheUQnKrnLA+gM5WEMfJke3y+4ibd7iYc1XP347zv8dJtE8oQX5zIoN/EAtBzMQpG7ajnE/y/wSC3NylbtjnGCGGdOiCKh/nIV5AkwRJov1Z6fJMiG5N37uHjSFaXtEFpAOjp58uVH8yFLYKNsYsJ3tAamViO7CjMP7mR22RV4fLuuTYQP7ygGekQv2FmnjqI9r9OZbJEf80Z4j9s1aU38yesimU2+bDmnc1Wz7JlscGKSIArWfgPWF2If2/4Nv6+nNFMYHR0YSzs8CzfKh/T9L4YM95j/8gAI2XgAChB5suPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RwGb4vDcVkRnBz/Li9TE5oJew3GBSG9x3hHQA8Nl5A=;
 b=OOXOXXmjwaHtQS5IdeqaGDN3q05M/LC3fiG4RB3BUdWjgVRf37Ox5+XNMuPkFt0sfvVLkFcbrYTZu0jhRq++FGcsBUbinUF6MMiuBbf8EwOdCqaSOPSixMT1qjcP5j1IN2/3lauc/NckQe/kOpbObdpZMgCRbeYkKt+Wmwj1B8KHv9Bc2DqM0EozFd0HBtZKnU2DJ7dVMHN19+DYOk5uG4yOrUSZNqyDvOxc2rCI9UtQfavQyd8SgFqIzhgjVyf1otQR3eu282Qd0RQ4uqyc2/ehE9YXBYOIyOTW4+43Lfda//hAnqZwlay82cuEx/wdZzqBqQtE2OqZmIMb45HqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RwGb4vDcVkRnBz/Li9TE5oJew3GBSG9x3hHQA8Nl5A=;
 b=NyemgLcQWRSg4xAOQSSugVt/e7TDmsVU/7XfIX+MTFivSYMQArrucyE5RejF5QfOGoy+ebufkWOhY5k0zWX28NfQzZVjQZRhllMtzMMf1yo1OpeOZ08Z8EBB/V6W8kEoizZwI1LCN1sDDiWEN7iJdVidw1NQ1rm/SSTZeORy9yo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 18:46:41 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%5]) with mapi id 15.20.6387.019; Fri, 12 May 2023
 18:46:41 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [RFC] usb: dwc3: core: set force_gen1 bit in USB31 devices if max
 speed is SS
Thread-Topic: [RFC] usb: dwc3: core: set force_gen1 bit in USB31 devices if
 max speed is SS
Thread-Index: AQHZhPNlNPBGFOTT10qNz/75xZwuva9W+joA
Date:   Fri, 12 May 2023 18:46:41 +0000
Message-ID: <20230512184630.2kt4xgneiovb3vac@synopsys.com>
References: <20230512170107.18821-1-quic_kriskura@quicinc.com>
In-Reply-To: <20230512170107.18821-1-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB6858:EE_
x-ms-office365-filtering-correlation-id: e0924771-f9b4-404e-c2bf-08db531939bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mIH8BZGCM6vewg0qLF6MknjpM2moFa8xyTLQIWhn4fGdICiFaVtKKgLkMt6r0FOPxj+XnA+boFx6hk/yNiywtvJNVwzurn27rzR0bjZrDrtwRH4BZQkEmZDJ9AU0AKHNXrOxdYjx/fRFTEKsVNC0Y2aZ8N8rPawX7tmY43jwxbM46tOxD07GSQu55Jv6zGJElB/CPblVz/s71K+25be3nyOqKwRDQOQVtrD30riTqSJ+cf+z9RxB2CxdHBtS2PZ7dcE54nhA23n/8O9OHf6et4UdvXWmRk1VBSd/P1L7f3m7O8TmL8nVnsL0qFpTOewvjrSclVdcz/L8mkutyndwAbip5HqjxV9wBjkUno1ntp79z5sNzfR2gRChQ2Y0R/1J+E0O/1SpfbYolq0NbcD84wup33g21YOY/H/wQAG23eFKlieN7yqMtxxXneYW/R9A7ewzKFYznAf86hLHJHkv4bLX6xA/jCXHr7Io4gRzdZWfanhb9in4wY2g5v0CgISEFgbwZTazZy7Go3kMId9Q5f/Zx0KBEniSyASnDD1LiZd1H/kG+jHQM7jRbxwXehx7MWmnVNN8PqqEyTYd9kCiGi9eADUTatf9oYM8NlaVCXc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(2906002)(38070700005)(86362001)(83380400001)(186003)(4326008)(2616005)(6916009)(36756003)(66476007)(66556008)(64756008)(66946007)(76116006)(66446008)(6506007)(6512007)(1076003)(26005)(41300700001)(5660300002)(38100700002)(966005)(6486002)(54906003)(122000001)(71200400001)(316002)(8936002)(8676002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDIvRzRHdFFWcm1kUWtuSFhZWEg4ajQva0xoTFpVRzFBNGw1bE42ZUd5SEVw?=
 =?utf-8?B?OWdLOEF3T0VORENtNC9Sc3hna0NVNEsxb1V5RjVhWFRmbnM3cHBwcndpdmp3?=
 =?utf-8?B?eitwem05b0svTE1rVlNWUGxUYmJ3WU9vTkF5YnBkUFBadHVTVXhpUG83NDQ5?=
 =?utf-8?B?bHlxVS8zOVQ1YWliRHF5VCt1WTBWYy94WWoxK09nZGdBbTRMZS9paENtWTBF?=
 =?utf-8?B?Tm1NNGFvWkRWK0JPblAyTTZVaWZoWGxiOGozV0M3Wlk2RDU3Q1dpUVZTR0tX?=
 =?utf-8?B?ZklKczB1bXI2UVAwTXpGa2EvR1pLTDFTdWRVMzBrU2lieXp2Y2c3aDVuTTl5?=
 =?utf-8?B?UTZSc2Y5MnJYNnIzMlh4Ujh1NXRuVWwyL2NETEE0RGFuTmdqbEJ5MTNKeVJy?=
 =?utf-8?B?d3V0SzNsMG9hZDBiU0VyNG9iSHVpYWhkOFB5Nk0xd003MVF4cFcxbk9wOElw?=
 =?utf-8?B?d1ZuRk9RL1pTc1NhRjgrY0RHZDNUQkV0OFJKaFNKVmoxb0JVZU9aSng5R2sv?=
 =?utf-8?B?TmloYnkrSEdSNnpvRllnY2VucThwOVVQQUo1ZXBZamlWQkNCR2djN0FYR096?=
 =?utf-8?B?YVlTQ1ZtVGJkWnRpSXdnY3duOHBuN1ovdjQ0cjNoQmxsZ2RlUVFibzlMRmNi?=
 =?utf-8?B?ZE92ZEJxWGk3MmZ5KzJBSG9LYU5NK2R5ZEVxMVFKWFM4YVpLSDlkSlRuellU?=
 =?utf-8?B?czk3VnZsMjFuWEkybDF0anJITXVmVnphRFlKcllpRUwrblZrZkQ4S21tSTM4?=
 =?utf-8?B?MnZPdVBJb25MWTZwTk9GWWtNVTJlSVY1WFdVZzVrczkybDNzNi9KWFhqZmQ5?=
 =?utf-8?B?cUpKQWR3cTd3Y1BycXpVZmdJek1iTHlIcHRFQTdnTlkyblFVNWZvalc1YUk4?=
 =?utf-8?B?eVJpVjRWbXJYMTRyQ3h4aExqai9nUy9OSDhPbFVpUXRpZHJLVGxZYnZpK1Aw?=
 =?utf-8?B?S0tjeUpjcXhrTEtOcWF0WTBMS1VENkVHNHZ5cm96cHVub0xvZjVhc2wxS2Iz?=
 =?utf-8?B?SUxlYUxGLzhQK1VoL0h4L2EvVllvYUoyTDFUR053a3hiVmxNeVVSQzVUeDlZ?=
 =?utf-8?B?WndoUE8xdy9acjByWGFycDRmSEVLNnMxcVZTZUNBQ3hKejNuYVFvcGlhZ2lv?=
 =?utf-8?B?OTZpRkVjT0JBMFVMUjZ1OXRYVldlV3BLU2t4SUhUcDk3djlpMFNIY2V1R2hh?=
 =?utf-8?B?cFliOUtZbGpPNWsrUlgwdEtZNWZncXh2ZWxRYzVzWGh5dExUdWlMZHZCNG5n?=
 =?utf-8?B?SWlSMzBWUTF4TDNOaFJ5T0czN2pEU0JMSFJZa0FZOHJFMWZSWGZXUnZhWXgw?=
 =?utf-8?B?SVhPejM2bDNNV3lldCs5T2dVajd4dmtRdGJpTTE0cDh6UllBby8zcjhBTnRZ?=
 =?utf-8?B?RjhSbkZtZmM5ZkdXeUZTTkNrTFkxNUxEQThGd2RXNC8vS08xLzAwOG5rQkFq?=
 =?utf-8?B?RTh0N3Bmc25INHlZeXdGcGR3U1lUWkU3WXZCdU9NcnZpWnV0ZG4xRUVURVpM?=
 =?utf-8?B?Wis3WkhvTXRFWEhsbDhXaGhDSnU4cm9xQWkxdjQzb1I5cVhZNW0yYTBwbmk0?=
 =?utf-8?B?SXh3U1U5TW1KcU9FZmhPY1pCOE12TVN0MHhqdEpUQTFsb2RPdDNvejhSenBa?=
 =?utf-8?B?NTI0MGlVR09oTml4Tm5BckhXd2kvcXQxR0wxSzRDbU43Z0ptTlNjQm92d0Uz?=
 =?utf-8?B?MFFvQ3hvSERZWS9GODRrNmhPU0kva1FnZ3JVOTlmMXFMaGNleVdacGtNaDRC?=
 =?utf-8?B?RGRGTWM4cG1oRUZaL3FXbG1qTVJERXQ4SU1RVElySGE2Vm5LRS9uaUxMSUFT?=
 =?utf-8?B?N1R6L05ycm9WalRHOERXOHRDNHh1SlMwOEtaN1NPZEhCdnlyU1pLZFRONGls?=
 =?utf-8?B?K3RMWTRRQ3g0VVNaY056WWtveU1ka2tQSE5WRFkvMGNpOThPMDBNZXlJNHN1?=
 =?utf-8?B?b1FPM0hWYnp1UGJFRHVQY0FCanVNY0lzSzJsc1N2b2tVd2FsSDc4WTRFaDlw?=
 =?utf-8?B?V3dkRVZaQUY1ejhTRHhCcW1mR0hOVWZKWWRmOTYzMnpmSXVyMy8yWTBqSyt4?=
 =?utf-8?B?U3FDREdXYSt0MENub3l6dG1tU25wU2RTVlVFSzc2S2l5dnJkVThkUnVVQUZO?=
 =?utf-8?Q?6D7IU0oVAGDrwyZ7pnbi5Sgai?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92C2AB0BA3C38D4FB6CFA871BAA26C5E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /IL+Q98fDT7x/3ZWIvkgGcLExTf4S4K4WUuACXHFXxppIhvMClnolAGyOtje1iucb4xSL+yeFAkkaESGRYCCW9mlF6bYgCM5AVZx6Zweky8y++z2+yt31toTf+GpSJ6OP3m1dHDqOxQL/HlsvvDCJQgIyEUL7Eyl4RFY6DKTUnGbaf0Pcg/1XnSUtlKcWmrBAWa5OdWSAoY5z58+bnQ+z7+mXCvSX62hZ730zyI9XmOEWx9MGNr402SwrlHX46jUb3VCJ5A+5ZcobN+bC77PtnuweVdPIpzYMu6cZpF/HnJotMy8PIhFk5eAo3oDcb/aQpU4fOenkSffpWcNfb9Zt68kHn+OgrMrAOO6dJP8OLl/64AFxq+8Z0WUsUZIegiTgmzz0SrHQMCaQMl/IAfUSVHZgPRYGYcuP06WWcmhvAmXvh8FFsUzEhpv5jPz6w7Tevz5CdJotRLctwI1mVe2sy/E+8obkMGQBs++IGxiy9MfTwvLh8khA6GwbPb10GtPY6V5ylIM9JvXPyZd6wmtV4XEF5PoEwcmv2+QTqszVwE0F57sAvgE0MjCVAaUDYPpb7oNa6kwvuNhVoAf0KNq9E80IZRxsV0a8JtwDAX+E5bAU7VVsa5Z2CaNLwOu08YQ54h3P1Z92ouX1CmMgrA8OhWXPFvCuhjNOhhzmlyFcF/S5R9yoVTv6r/rPYMJ2y/zeUUU7J6yNjAkfhHvSzuIi4f5Z5WbpvVQ8x5BwP3DG57vhqqNo25XEHfO0PtWuVy+q98YU6jEXqmPmG/MShVwAsutXwijFF1///K72KjtYT8lgI3RkFE0NIKchC+SrDoz9ctUL/gSoyPZyIlIG9WiL0+sZxo+7+/Kn/k99sZferOrite4ycFCa2bNaaiYsVIoj50B42HbR2opmiNgqf9btQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0924771-f9b4-404e-c2bf-08db531939bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 18:46:41.0597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4GHqFPiJDLXZUQ3JPg2MhZgDftcmM1XkyX88mY00dloWYC4Ru9Yw7Gg1NfdX31pA4/QtB1tPu/KVbPUJcfzBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
X-Proofpoint-GUID: I4Cl8CLMJh_kuExNzEpxa4B4aKOHD-Gz
X-Proofpoint-ORIG-GUID: I4Cl8CLMJh_kuExNzEpxa4B4aKOHD-Gz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXkgMTIsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEN1cnJlbnRs
eSBmb3IgZHdjM191c2IzMSBkZXZpY2VzLCBpZiBtYXhpbXVtX3NwZWVkIGlzIGxpbWl0ZWQgdG8N
Cg0KV2UgdXN1YWxseSBjYWxsIHRoZSBjb250cm9sbGVyIGR3Y191c2IzLCBkd2NfdXNiMzEsIG9y
IGR3Y191c2IzMi4NCg0KPiBzdXBlci1zcGVlZCBpbiBEVCwgdGhlbiBkZXZpY2UgbW9kZSBpcyBs
aW1pdGVkIHRvIFNTLCBidXQgaG9zdCBtb2RlDQo+IHN0aWxsIHdvcmtzIGluIFNTUC4NCj4gDQo+
IFRoZSBkb2N1bWVudGF0aW9uIGZvciBtYXgtc3BlZWQgcHJvcGVydHkgaXMgYXMgZm9sbG93czoN
Cj4gDQo+ICJUZWxscyBVU0IgY29udHJvbGxlcnMgd2Ugd2FudCB0byB3b3JrIHVwIHRvIGEgY2Vy
dGFpbiBzcGVlZC4NCj4gSW5jYXNlICB0aGlzIGlzbid0IHBhc3NlZCB2aWEgRFQsIFVTQiBjb250
cm9sbGVycyBzaG91bGQgZGVmYXVsdCB0bw0KPiB0aGVpciBtYXhpbXVtIEhXIGNhcGFiaWxpdHku
Ig0KPiANCj4gSXQgZG9lc24ndCBzcGVjaWZ5IHRoYXQgdGhlIHByb3BlcnR5IGlzIG9ubHkgZm9y
IGRldmljZSBtb2RlLg0KDQpTaW5jZSB0aGlzIGlzbid0IHJlYWxseSBhIGZpeCwgY2FuIHdlIHJl
cGhyYXNlIHRoZSBsaW5lcyBiZWxvdw0KDQo+IEZpeCB0aGlzIGJ5IGZvcmNpbmcgY29udHJvbGxl
ciBzdXBwb3J0ZWQgbWF4IHNwZWVkIHRvIEdlbjEgYnkNCj4gc2V0dGluZyBMTFVDVEwuRm9yY2Vf
R2VuMSBiaXQgaWYgY29udHJvbGxlciBpcyBEV0MzX1VTQjMxIGFuZA0KPiBtYXggc3BlZWQgaXMg
bWVudGlvbmVkIGFzIFNTIGluIERULg0KDQpBcyBmb2xsb3c6DQpUaGVyZSBhcmUgY2FzZXMgd2hl
cmUgd2UgbmVlZCB0byBsaW1pdCB0aGUgaG9zdCdzIG1heGltdW0gc3BlZWQgdG8NClN1cGVyU3Bl
ZWQgb25seS4gVXNlIHRoaXMgcHJvcGVydHkgZm9yIGhvc3QgbW9kZSB0byBjb250cmFpbiBob3N0
J3MNCnNwZWVkIHRvIFN1cGVyU3BlZWQuDQoNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3Jpc2hu
YSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4gLS0tDQo+IERpc2N1c3Np
b24gcmVnYXJkaW5nIHRoZSBzYW1lIGF0Og0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2U0NjVjNjljLTNhOWQtY2JkYi1kNDRlLTk2Yjk5
Y2ZhMWE5MkBxdWljaW5jLmNvbS9fXzshIUE0RjJSOUdfcGchWWlRcGpaSUpBdy15dTZnRXdiS3Fi
NW51c2puS1E5ZFFKcnVseDM5bFFQLTdKTWhjTkEyeGQ4dUxKb1pfSEU4U3VHNFJtMnV2aEpUU2RR
MmswZkpWQXhVMlJXWUhIZyQgDQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAxMyAr
KysrKysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8ICA0ICsrKysNCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggMGJl
YWFiOTMyZTdkLi45ODlkYzc2ZWNiY2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0xMTYsNiArMTE2
LDE4IEBAIHZvaWQgZHdjM19zZXRfcHJ0Y2FwKHN0cnVjdCBkd2MzICpkd2MsIHUzMiBtb2RlKQ0K
PiAgCWR3Yy0+Y3VycmVudF9kcl9yb2xlID0gbW9kZTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHZv
aWQgZHdjM19jb25maWd1cmVfaG9zdF9zcGVlZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiAr
CXUzMiByZWc7DQo+ICsNCj4gKwlpZiAoRFdDM19JUF9JUyhEV0MzMSkgJiYNCj4gKwkgICAoZHdj
LT5tYXhpbXVtX3NwZWVkID09IFVTQl9TUEVFRF9TVVBFUikpIHsNCj4gKwkJcmVnID0gZHdjM19y
ZWFkbChkd2MtPnJlZ3MsIERXQzNfTExVQ1RMKTsNCj4gKwkJcmVnIHw9IERXQzNfTExVQ1RMX0ZP
UkNFX0dFTjE7DQo+ICsJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19MTFVDVEwsIHJlZyk7
DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBfX2R3YzNfc2V0X21vZGUoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzICpkd2MgPSB3b3JrX3Rv
X2R3Yyh3b3JrKTsNCj4gQEAgLTE5NCw2ICsyMDYsNyBAQCBzdGF0aWMgdm9pZCBfX2R3YzNfc2V0
X21vZGUoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgDQo+ICAJc3dpdGNoIChkZXNpcmVk
X2RyX3JvbGUpIHsNCj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfSE9TVDoNCj4gKwkJZHdjM19j
b25maWd1cmVfaG9zdF9zcGVlZChkd2MpOw0KDQpUaGUgTExVQ1RMIGRvZXNuJ3QgY2hhbmdlIHVu
dGlsIHRoZXJlJ3MgYSBWY2MgcmVzZXQuIExldCdzIGp1c3QNCmluaXRpYWxpemUgaXQgb25jZSBk
dXJpbmcgZHdjM19jb3JlX2luaXQoKSBpZiB0aGUgR0hXUEFSQU0gaW5kaWNhdGVzIHRoZQ0KY29u
dHJvbGxlciBpcyBEUkQgb3IgaG9zdCBvbmx5Lg0KDQo+ICAJCXJldCA9IGR3YzNfaG9zdF9pbml0
KGR3Yyk7DQo+ICAJCWlmIChyZXQpIHsNCj4gIAkJCWRldl9lcnIoZHdjLT5kZXYsICJmYWlsZWQg
dG8gaW5pdGlhbGl6ZSBob3N0XG4iKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggZDU2NDU3YzAyOTk2Li4y
OWI3ODBhNThkYzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC0xMjEsNiArMTIxLDEwIEBADQo+ICAj
ZGVmaW5lIERXQzNfR1BSVEJJTUFQX0ZTMAkweGMxODgNCj4gICNkZWZpbmUgRFdDM19HUFJUQklN
QVBfRlMxCTB4YzE4Yw0KPiAgI2RlZmluZSBEV0MzX0dVQ1RMMgkJMHhjMTljDQo+ICsjZGVmaW5l
IERXQzNfTExVQ1RMCQkweGQwMjQNCg0KUGxlYXNlIHBsYWNlIHRoZSByZWdpc3RlciBhY2NvcmRp
bmcgdG8gaXRzIG9mZnNldCBvcmRlci4NCg0KPiArDQo+ICsvKiBGb3JjZSBHZW4xIHNwZWVkIG9u
IEdlbjIgbGluayAqLw0KPiArI2RlZmluZSBEV0MzX0xMVUNUTF9GT1JDRV9HRU4xCUJJVCgxMCkN
Cj4gIA0KPiAgI2RlZmluZSBEV0MzX1ZFUl9OVU1CRVIJCTB4YzFhMA0KPiAgI2RlZmluZSBEV0Mz
X1ZFUl9UWVBFCQkweGMxYTQNCj4gLS0gDQo+IDIuNDAuMA0KPiANCg0KVGhhbmtzLA0KVGhpbmg=
