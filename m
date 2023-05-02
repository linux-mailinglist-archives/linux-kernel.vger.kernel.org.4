Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B836F4CF8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjEBWkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjEBWkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:40:17 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BA0358E;
        Tue,  2 May 2023 15:39:48 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342H97A4004572;
        Tue, 2 May 2023 15:39:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=FBI5Y5b9uAMIhM1jCioE0DUqmUgiSQDpRkIcILJ+VeY=;
 b=gMzHPWd+22aO+KLHn72uagDjvXJnM3nhm205UuSzS646D0Lawao4cOiT/dchkTyqfj1a
 n8jvhuYh+59rwZrrFiIj781hJPIwe4PtrICk52d99mfjkAqTm4fA3AaML9DGwjW0A4fq
 qICcyUPDoEHczGvlYD2+hv+jSBrN6Ww/HhQ0QRgrBSP4JBOMMRyy6iBiWTiWqPbnpq3r
 Uf5T/9WbB+UtO6TGVYGZFVYtUBXHFr7pGpw/vU66o4JVBfhuVCLETPD+MPe2p7o2HEPK
 RpSQjK8xB+3giICg/Vqhiv6P709QZLIOFwJ5ws9bO7eqyxY+ifkqHkzJRoJud23Cfbs8 pg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3q91vj72tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 15:39:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683067177; bh=FBI5Y5b9uAMIhM1jCioE0DUqmUgiSQDpRkIcILJ+VeY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Y+t6pjntShDpEcfyyDemCrI9KgVSMmaidws1FxCmWooIiNVSPyogBdbfQSUvAET4R
         hSEd7vwa98I53amSOzVkGs38d3kifEDLC5e0NdR2LXEPhTdbdhjrwx5RaeZFTSnAyN
         xtwI4ZDdqsd+ZrSukXW9mQSsUHy9+PsFNUvqFup9F7az+tvD9YU/HlYvknUCW5b83/
         skoZwnN7aM5MRItEo2iMghjYpwM6pszNoucHwEkp/vs6Adqayb/LLAQUZkj3W3lcBa
         Heb2LIDIYN0l5eyGCSJ4AXIUFM9Uqfr9A1+HCvprhm0fbGhtKiAt53EfIjKuuKM3oP
         GGnD0uvGL2uiA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6EB1340523;
        Tue,  2 May 2023 22:39:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D87CFA006F;
        Tue,  2 May 2023 22:39:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rwYnG61H;
        dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7D8804045F;
        Tue,  2 May 2023 22:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvwXKTwIzIe4IGYxJlVSF7TqnbmSB+bQywlUFdVrdFfmOaYWtpeqwekfvI6wd4TrrfdwkqdZeYewtZ7dKluoW2N4qzx1oQ7qC2hpvHTqFOO4DkVoHmEbEUG9r/RmzPFY2L9Fo5vXeDiv7NHHQ63UiQUIdXQqTnonu78z/EKddSePQ4GrW+N+vly2cdi0P2Lwyfbr/fc10L5YiBLD5HI4XRbyGRGcqRVi3uVUnykTm2OReBx4jd6vhiUxCjD6jOSgV82XsWe8Cb+ZIbMwdS35f4tnbJaFxHNYxN3uyd5ic4i0OmY6FVxlqTIUzLiNpaGKx+462pjfhO6w5Zc9Q2ebeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBI5Y5b9uAMIhM1jCioE0DUqmUgiSQDpRkIcILJ+VeY=;
 b=NwTq/7fagnvJrpdiaUlNenrqMukJehSdLONeOcZHebpyyNk+v8XGf7TqPjjr3/gNU0qHrj5dOZ5aTATcpvyKVX30qKIsKMjmIwjH/jugDNJP+ZKG8pOULF475tPkZ3EFtCQS5jUrRF6ppBXL3zMxBi3wQd0Cwv8iT0Agfwoeaa5l4eQX8i/H4dUi7wDCFe9XLICResB6OQ0vmGf2qwbUZEHA3XC5PNVts1Ezr9Y5dz2AdWuA0EJZRR1b7yBomQmivqMcyvCEZ17egehdZOnmS8W+qMmLR+y+mG+vMNTeTpaa7/OHb3F4rClp8RuvukYOV+OOECPfPr/7VtOpK4Tfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBI5Y5b9uAMIhM1jCioE0DUqmUgiSQDpRkIcILJ+VeY=;
 b=rwYnG61H2pBgzhiDBuxHyz97Kpq9i9mJSqVEAeK4foQVaJqBeyDlcLCfE3go2kOOrbgpCAhyLZhZrEYNZhUgFsgBCV5yxKXXv2jvtdTJ8m+gmVuBoWLXDIkrMNfi1Zgu7R5QJSXnrlFwnu08aT1w43vCOYtPrY2QnQp4wddQAQI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 22:39:30 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 22:39:30 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Stanley Chang <stanley_chang@realtek.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] usb: dwc3: core: add support for RTK SoC custom's
 global register start address
Thread-Topic: [PATCH v4 1/2] usb: dwc3: core: add support for RTK SoC custom's
 global register start address
Thread-Index: AQHZfLOqlY1W2Ii4CkekbWMOKFVBP69Hk6cAgAAA2IA=
Date:   Tue, 2 May 2023 22:39:30 +0000
Message-ID: <20230502223927.oyv5svn7gxhqi5g6@synopsys.com>
References: <20230502050452.27276-1-stanley_chang@realtek.com>
 <20230502223626.uyld3tv7d7fnbt7h@synopsys.com>
In-Reply-To: <20230502223626.uyld3tv7d7fnbt7h@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SN7PR12MB6744:EE_
x-ms-office365-filtering-correlation-id: a0e6d903-19d2-4428-afc2-08db4b5e17ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CL3vYIzYdTh/AqmkCWgvfxP9mk2J+7qkVHzjFShAyYqyboDARcShlVD82hDXbbpCyU3VUnFvAF7dM5W/PgU4cO0kUBJjQFmWZ9tyayFd5t3knHrBWMuTWDWAPDaoj1uNi+BowOknZZ5ooJxe21oevKIy+qAxGayoKDT/JGJqYiNZ6kH/L0gfKISKeV2wAfzllbgGN2Ye58sgWsGC3oGFG4v6HSuR+Ot5uO7Y6aPJG7kNaeJ7CH8tMhvOEy3L8Z9j4gpeclSOWgSdCaRj7q6BgOIRkQYIyf7chFuPCnaaPH/3vC8NkadarQMiausdQL7T4nehbc0wjfyZNXf3HqZUymkX9ncyDin4onYgVglkZMFyA20Xf6TNQArevdIkghnbJdViL2Q9702gDcxlnuJxMs7VvwMDn5NXnZBErCbZEImy1jI+PGeZn7v2sk+5QLedbN7AFc8Yb2O6Gez2ZYvpbGFFBC7WTlopM8RgEBBXvQr1lBT6UX7u3T921THozPT4Px9kMnDbrbraCKwCbJqxYFtAtBxgcviTEv9b/hXAE3G6VGeKu9xB66/Isezb2BbotkQMN/V2a+JyGX68ufwjAZbXkESlYVhiZZ4tLk0lxlyjt+svexrOK8Rzhg6+u0J+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39850400004)(451199021)(5660300002)(8676002)(8936002)(41300700001)(316002)(38070700005)(36756003)(86362001)(2906002)(4744005)(38100700002)(122000001)(186003)(76116006)(2616005)(478600001)(26005)(71200400001)(6486002)(1076003)(6506007)(6512007)(4326008)(54906003)(6916009)(66946007)(66446008)(66556008)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1JsWVlQaUNyS2ZzcTNQYXhUSmhsWjRNT3owZGhGYk5FKytDWWY4TjQ0amxN?=
 =?utf-8?B?ZFB4SFpZN0xJVzlpOGVLVzR4RENDMHhRaU9lTkNuSS9IMm5JRWRWeVpGZE9h?=
 =?utf-8?B?Q25tRzJjTkV5UHZXZGpyc09DTklPQ0c5c2p5U2xUTHFpT1pnUGlheWVPbERH?=
 =?utf-8?B?RnduNkttdUVUTGYvaUJlRU45RGpxQ3RVMWJBdUlCUTRPVVJnZThXTzdiYmcv?=
 =?utf-8?B?Rkx5TDZ4c1N4WUUxQ0d3bFBtMkRQQzhPcFFFNFhlZ0dla0xyUlR4emVOUERt?=
 =?utf-8?B?emZRTVJ2Rzd3TWQzaDJJQlpxbGFnK29FMFZUSzZkeWdIajhmNXcwcGMrSzNi?=
 =?utf-8?B?ZlBiQU1uc1pjSkVwajFOMkQraUxLUnpROEx4TXE3STcvbEwwVmFSbWwzZWpL?=
 =?utf-8?B?dzdMRkNndmh0M2wvQkoxVEM5K2xJWmFSSVMzMXYrSkoxVHN5ejdZTGpBTVpu?=
 =?utf-8?B?QklCZktaWHQ5MjY3QXArVHM0Rk52TE9IZ3c4WWJuUnptMVB6UjNFaVM3V3hX?=
 =?utf-8?B?SHlVRkVOSDg2YVRpQ0lja3E5Mm9lcGhENlkzaFIvMmpOdWZjUVAzOVVUbFdi?=
 =?utf-8?B?QW81R0ViWjRGRW5CaUZIYWZyV2F4eDBSelNnc0JmRktDdVpyeEJWQ2xFNWxV?=
 =?utf-8?B?VThkMnJ3SXMxdGRFdXVqWkpCbVRKY2oxN1JDNU9HdXhBSWNxTngvc0R5WUxt?=
 =?utf-8?B?UnNXRGlPaUJMTm8vbHRJS3hkbjlzblhVais1UDh5clBBMmVjNUhxQlJVem5j?=
 =?utf-8?B?T1pKOHF1UEVPWTVITlRUZXM4dElkczJSdmY2ZmJ1eGRtTUVQK0JTTkdXTVc4?=
 =?utf-8?B?UloyeFNCMXRzQXM2bitrZVJuNGViN05qYm43aWVGcitqVndKNnc4dVArdEpj?=
 =?utf-8?B?TWpGSTZJV1U0MGJ5OVpmNEVMTzEwbnlUTzYyR3NIMkpYcVZsTC95R2tQTTIv?=
 =?utf-8?B?c05YMmxHZ1NJdlgvbDN1TEplbDVmL2xzS2hRdm5iQWRyQ1paMTU2d1ppaDZK?=
 =?utf-8?B?UGgxRG1JY1JyQVpTVmZlNlFIRzljM0hWcWRuU2w1NnhaN2gwclhlWUlDRUI4?=
 =?utf-8?B?WFN3T3N0c21uSk5qZW83VGdjWWd5aG9adk1jQWc4Yno0eVRYWnBsU0xMT3Jv?=
 =?utf-8?B?bG15TXJTTWRJUy8wYjZ2MVVoQWw5U01KL3R1QTlodGlrRmI2V1BUNVFJUzZr?=
 =?utf-8?B?NHRIa21FSGJjbm9LY1REM29yaFRldHZrS2VWMDZocjRDUUtId1A2UjYrQklt?=
 =?utf-8?B?UU4yTTJxNjNpaTU0QzRxOWZ3eU1ZZ2VYMWxxK2FpQ29rUWpyVUFLR3A0VlVI?=
 =?utf-8?B?eFRXSmtIU2RpSVZaaUJJMER4OWs4dzYrZDRwVzkzL1JobzZzb0J0dGtVQzhl?=
 =?utf-8?B?QWVUOXZuZndGbHI4Y3BWRk5mRkRaditxSmR4SjZvSWJMLzdnTCsrMU4vaHVk?=
 =?utf-8?B?aXR4a0hSTk9CNWZxWGEwbXNicTZZZVdPUlNJS2t5WFpkdFRlT3dOZDNtNTdL?=
 =?utf-8?B?V3FUTk03UjVKUnZ2c0VNYnB4d01yQ3R6bCtjYmZjbVJHaUE4enBFTlhDa3Fw?=
 =?utf-8?B?RzBid3dDR0xta0MwZTd0ZVM0NFpweTdJNWkzWGMydDdRTGlqaXZPdGNYOW9Q?=
 =?utf-8?B?SlRkemcyZkhRbGR5NnBIS0ZGcmpyR0tPRHVuc2lLNXVYT2pFNDZGdTNSaTk5?=
 =?utf-8?B?aXdMRkgrODlETERTVVNhYStjSFRPbEJiSGJQZHNwZUtuMy9JM1VndlBkOENF?=
 =?utf-8?B?WWVzdk80TzZyT3BMWnJOSFI2QzYwRS9TcVZib0tDU3Nab0NwazVHSWx4cmJa?=
 =?utf-8?B?cUpWOUJNdktEWVdqdno4Skd5K2VZRlcreDBNMVFmdTA0ZzlGdlBnTkR6M0tM?=
 =?utf-8?B?SmxSQ21WOVE4MzZoUHk5Nlp6eVVPeDUyWGRicU9MQUcrMHVaY1cwL1FDUUVm?=
 =?utf-8?B?ZHlVU3l2QXBGSVpxQjFIcEt3bnY2d3B5cU5VSFJXK2dRcGdmdUQrOGxlTStX?=
 =?utf-8?B?Q3Y1SXA1ejJZWktzZ3JINkozN0ZJTys2K016WDhhUFpZdzZFVWNpMmZHZDJ0?=
 =?utf-8?B?TVhWQnUvOVQvYnIyMWZhQzBMS3YzN3MzNjhMZFFUcGh1MzRtM21adk1JZVgz?=
 =?utf-8?Q?jpYer4pMt38NF/ECFJsTslHy4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C43A07F0567B154FB8E3EA58D7255F62@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OHhBS0VnM0hPY2p3dmhIMHc4TmsvdG00NzhaZ1pvd0dYbmh1VDE1TnNPUFF3?=
 =?utf-8?B?eVJISk5DTFc0UlBBNHd5SnpvcDYrN1dUdXpONDJhRk44anZBdVVKTGc2RTMx?=
 =?utf-8?B?VzY0YnlWMTlPeDhFMUF0ZUpCMEdFNUQvZENuK29rc2x6S2dSM1BmSGFOQWhD?=
 =?utf-8?B?RFE1Y0dHWVkzRDgwVXQwb2l0SFRwdHFma2VPKzYxbkVWakhTTndOenNraXov?=
 =?utf-8?B?Y3IwTFhuUS8rVXB1bXdNTHh0cUFEK3E4ZmZ3NnNOUUh5TUE5MHhHN2NzZFlv?=
 =?utf-8?B?M1JtRE1qQ0xjdGtQdmJuQnY3Nm9wNEZIYzJ5aGFodGpTVWVid25qR2NJb2hK?=
 =?utf-8?B?UWlTd1ZMUndIU0JKZ3JpU3hMOTI4S0JoaEFYU1NqOU4vazlVd3FnMWcrZkph?=
 =?utf-8?B?ZzN1TkFyRngyV3RhK0tmWlJqejJBSWhFOFYyQTIyU2IxZzZnM002R3ZzODlJ?=
 =?utf-8?B?bHh3V1hPcnMvS2h6RlFkM0NmRTJpdGtIV09tb1hnUFFKQVdyV1U4eEZGakNV?=
 =?utf-8?B?QnZsaDZLQkVFRldzZ00xaUNDU25pdm9ERGxtYUw1ZXJlNHRIemg4alFOdzJs?=
 =?utf-8?B?QlkwL0dwNFNzNEc0aUtlUmJ4RTZCdWZtWXRLZUtkZnZlR1BCR0tqbU5qVjk1?=
 =?utf-8?B?amhFcTdlc3NVTW51Ly8vRkVJVm9tMjV3b3FMbFlnQmY5NG4zaGNHVzF3THli?=
 =?utf-8?B?TFNxR05WMUY0Q2twRlRqZ2ZGY1Fkc1Fjazkxay9Ua0RHK1loVGthZ1NEUE5l?=
 =?utf-8?B?Q1RNa3plVnpPQk14UnhnTmNtWnMzdXVRdzY0cHF6QURyMHN2RGUvWWpWZU1r?=
 =?utf-8?B?Z3pQWERRMldXVmVRYjNEWXRpWEZvSGJTMzFSaU1OclNRZmI1akpvOVRPSGlH?=
 =?utf-8?B?SUZBUE1rYWlJTE5FeFJWeXdWcFVFUXZDa1NSNGJzYWlSTTlnc2QyalZRbFhr?=
 =?utf-8?B?dWlEZnpzOXVRcFFGc2dsOG1SQ1FacDRpdXV4dWVCeW4rNlRhRzF0dDRDUmgz?=
 =?utf-8?B?WnJsY285UnFVQ1piY04wU1dCM21hb3dxcy9xbGFUbHVDRjQwbWhncXpWWkVB?=
 =?utf-8?B?UitENkc4SnJaaS9PSU90eHB6UXg5Rm41OW1XTlFseGw5MkU4dVJDVEFlcVNX?=
 =?utf-8?B?V0wwT1RiVHFwMjFkRjZjeTFkU0ZlZFAyL0NPcHk4TTN1SExXTnQ3d0wxRjI4?=
 =?utf-8?B?NnhGeU5nQUt6b1dhc3hud2lqZzJBOVNOc3BSY01MbDRmY3B4Q3dic3k2T0p2?=
 =?utf-8?Q?EU/4dwUGuX019nj?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e6d903-19d2-4428-afc2-08db4b5e17ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 22:39:30.4353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5NFGlsXuLKpLTlFynv5+jIHA08+A5wj8l9HmsucsU8iCnT5Mp3qvkKWRx4E+4yyJAszueXASQr9UZOMn2ja8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744
X-Proofpoint-GUID: wQn7ko3Ez1MNF0SzPScm0lu9gtU75L01
X-Proofpoint-ORIG-GUID: wQn7ko3Ez1MNF0SzPScm0lu9gtU75L01
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=751 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWlub3IgY29ycmVjdGlvbi4NCg0KT24gVHVlLCBNYXkgMDIsIDIwMjMsIFRoaW5oIE5ndXllbiB3
cm90ZToNCj4gDQo+IERpZCB5b3UgdHJ5IHRoaXM/DQo+IA0KPiAJZHdjX3Jlcy5zdGFydCA9IERX
QzNfUlRLX0FCQ19HTE9CQUxfT0ZGU0VUOw0KDQpJZ25vcmUgdGhlIGxpbmUgYWJvdmUgZHVlIHRv
IGNvcHktcGFzdGUgZXJyb3IuDQoNCj4gDQo+IAlpZiAoZGV2LT5vZl9ub2RlKSB7DQo+IAkJc3Ry
dWN0IGRldmljZV9ub2RlICpwYXJlbnQgPSBvZl9nZXRfcGFyZW50KGRldi0+b2Zfbm9kZSk7DQo+
IA0KPiAJCWlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShwYXJlbnQsICJ5b3VyLWNvbXBhdGli
bGUiKSkNCj4gCQkJZHdjX3Jlcy5zdGFydCA9IERXQzNfUlRLX0FCQ19HTE9CQUxfT0ZGU0VUOw0K
PiANCj4gCQlvZl9ub2RlX3B1dChwYXJlbnQpOw0KPiAJfQ0KPiA=
