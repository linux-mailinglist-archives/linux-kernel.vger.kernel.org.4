Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE306C5C81
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCWCSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCWCSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:18:00 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE8293E3;
        Wed, 22 Mar 2023 19:17:59 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MLdPtX012229;
        Wed, 22 Mar 2023 19:17:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=yDKp2hzJgY3IgUR+9IlG67hrwU0p0fFDXITJ4wJ6TJw=;
 b=ktRM10jqwMaypQ35sy1wRulnHnx6IrxZvBnlS6840zartQpE8A53vuMTAymwsW6smEou
 mcJzVmkxxKC0P4N8+0zgaeuhtP25s8iMrQrKpHsxevqLmvevxw3iCYF7vGmCQi9yR8/N
 wBlXy2geiD7WtVUuk9AdKSwJ0HccN+sQ3X2rM5e98Y477VFVFROtJUGUYf9XqUI8hdHf
 zXAR8vOHXPFFdSfzJIXXV4FBmopREUuhW1GCZRtHTQ0NpF06Kt4mLRRaXW2YtmNP6GvQ
 YwFwQYicIfoGCwDrrq0KxpG/vED9dZ5qFgGCGQOp7luuidAWH8mxqAWZp7kSx8mNZg41 Mg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pdc7ws3dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 19:17:43 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1E6A3C0443;
        Thu, 23 Mar 2023 02:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679537862; bh=yDKp2hzJgY3IgUR+9IlG67hrwU0p0fFDXITJ4wJ6TJw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=N2M0FrViofrqvb+KoXYuSR201O6r/qoqTrYW8dO8240VEKUhzHBwWrAjXJxxDZl9n
         R6o0tA4rT+VxdxikgFXyDeiCXEz3a86bFiZi+C/GrjTrcQY4F1xmP25cGkP7b27Agr
         8rwuCJ5lYdH03MvU5rxBz3QJffvWTW+l0c7hgmUO9lv157KEortnt3GD3DaJC6Sp6y
         sPpyQkw1d1EWvsUfX9vkyOfrm0SSjcNt5hE5xj37Th6nQyoDMrZf8WnC/xbJ0agewR
         AuCXxlVf35fqRPs050bbMN4piUnoyfDSrooDKJRJUr0jqLSJ1c1C4fLvnarcoffpP4
         8tM0zC36XhPhQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0F9DFA0074;
        Thu, 23 Mar 2023 02:17:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2FF3940109;
        Thu, 23 Mar 2023 02:17:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ww13Q7Qz";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJWBpVpNszgCW/p81Hafi8cGQm0+1D/+mjlHvHyxLrBIKMefMYvS1Mgt+dSq6+2XRYg8xza20WbXgGWrehxY6xdDP187lCqOiGTfDwykQtK7/vQ9NvCYiTYQstq/xsstz/wifRUodGlA1OiyKKW33uE1Tz079XaeyXo0DykYh2progyhRjpJFxZfdUOzeTuS1dFo9+w3psroUsuC6AaXhDZk8LqSUepOqrxe7aT3Lyj1jdFvnLInqBpXkxziZjfCPvIABoRw7JSi4Dg2HHeC2CsBsWeTX3pLAn94NCPJACnWUVFxy/lwrwaaFzqhUpLSwnq2bTqnDHz7g8v9uy6jfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDKp2hzJgY3IgUR+9IlG67hrwU0p0fFDXITJ4wJ6TJw=;
 b=QrPMIgt4GhbLSkToBa6LMgusFbQ7PXBrOHNqUUgegU1m7zmKjrn186dNcuJCgCOQuOuj0J1Kkv8Zy7gJzbAcRih5cIzh4v0IXKofRZRpw5DEeUwRCpEsLXovpOZlSB0ZrY7PMPMF/V2xXF4KeLe9RVnyBQWgf8dP51pn3gh7WOaVi+Aic6gNoeiUfaCxXi+lrxSHtFbSqx3PPoQ/1EQ0eHKPI1anZXfXVrTY+wy4TnK3D33g13xdljAMWk4ARgBNwE4QdePJDWl7JezoQP4THdAoWV3fpfzfsN2ybmGTe19v+Z5oYUZU0zoRXeygyh9/GrYRJuHruSfK/y+QSXos4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDKp2hzJgY3IgUR+9IlG67hrwU0p0fFDXITJ4wJ6TJw=;
 b=ww13Q7QzUvbx5a1KMjbLBbJbNr7C267wRWDo8z3vH14XgVeevQCAgHDUo2CFDtXY2TKRDhvcOxmdfKplQ7IRqpYizzd5l+WxPBha4N4+6BuJWUs6HGQX3CCQIf52TrHnS97p6RObrOE9QuEwelrOiQNR7uG/366kSYV4Jr0dLUE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH0PR12MB5074.namprd12.prod.outlook.com (2603:10b6:610:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 02:17:37 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 02:17:37 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com" <srk@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Thread-Topic: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Thread-Index: AQHZWw9BydGhQRYXjUGBS+C5GU6+168EBAMAgAEDRQCAAIy8AIAABewAgADbzQCAAJyDAIAAkueA
Date:   Thu, 23 Mar 2023 02:17:36 +0000
Message-ID: <20230323021737.pv2nrb2md54a5pdg@synopsys.com>
References: <20230320093447.32105-1-rogerq@kernel.org>
 <20230320093447.32105-3-rogerq@kernel.org>
 <20230320185206.a4o4bmhml7rlg6f7@synopsys.com>
 <48814d21-24d9-3141-68c8-316d071de1a8@kernel.org>
 <20230321184346.dxmqwq5rcsc2otrj@synopsys.com>
 <20230321190458.6uqlbtyfh3hc6ilg@synopsys.com>
 <7db7eb59-68fc-b7b2-5a29-00b698f68cbb@kernel.org>
 <20230322173150.nscqyzwcrecxjuaa@synopsys.com>
In-Reply-To: <20230322173150.nscqyzwcrecxjuaa@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH0PR12MB5074:EE_
x-ms-office365-filtering-correlation-id: cd51307c-8a8d-42ad-4223-08db2b44c53c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/sm1tYjCFteACu3bMjmcs91a3Zn7KJJYsOBH2fj7j63LdrPz827LTpzKbvACilDA2+bChICdkwqJ9P9gv4RY76hmJae4AxmKch7oYVIxkBwQossSWYwFbeZoz2fd20JTnmiX0q8AXcXGNByx50p+0keqZ1eVZoPcJ5+o9ZufFYmUQKxr2+/myydTenn/9knQ8OnZaytDG92ktkFnZz5kQAst/lMkSGMfHZBvFFnHUB42jQAZoZJWHvNBIL7JtjCCjAcJlTzh9T4InlXAyOL6IgmwST+i4mGmF88KYobILpx84fokIWj3m7fSEal2ywRNv/35hcaKRjTZaqFSDlbrWbPbLTmkURdk6V8wp4708JkLWLzF2dV+ift1nnwOxlUhiMdr+bQWqFnN9w/mPDHsmDzIAC/C5cLaPZOQoOUOm2T2poLdiG5dSlIskfdGPOKCDjyFvIGI6LqDcJsLIUPrBHpwQQI3dzdutpS5cx5ffzC5a0QjNonpSVcm+Yipzgt9KnZcTeLIZqRSsdX5z2YFsPR82vysTXVil60zlUJFQCoDccdgJkym6bnxBsSGeizet8vK3NBUOJZ0dnAY4ihBMRqfTjFjqJ6isPln6qc8ukcMA2QBuVAkKMdzmAiLX0CO8H6w3IrJc06UiMMP4BnkcDMLqtvAAAs8jDn7txeow9d0vVdLgeaF4Vv3KaY022lInG8N4ejX+GI8GhaE4gpMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199018)(8936002)(41300700001)(5660300002)(38070700005)(86362001)(36756003)(122000001)(38100700002)(2906002)(478600001)(1076003)(186003)(83380400001)(2616005)(71200400001)(6506007)(26005)(6512007)(66476007)(76116006)(53546011)(6486002)(64756008)(66556008)(6916009)(66946007)(8676002)(66446008)(4326008)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmMxa3ZuVFdVdkVDWGVnL0RUckZ6azZMaGtCenBjdzZhNHhQN3hkZUZCWXN0?=
 =?utf-8?B?dWdZM3hNbDJUaVJYWUxhQk9QNThiUWlocENOYUNQRzNvaks2eVJROG92anFh?=
 =?utf-8?B?VVVJR3NWVyt4Y2lHMUxFNVFLbFVYVFptbU5uQXVTaGNVRnZtZ3QzNkc5djNx?=
 =?utf-8?B?d3NvNTBuSTFpTC9vZklLYVJKVU8xb2tvRVQxQlk0di84cmp6dUlGZUdWOVdu?=
 =?utf-8?B?MTJvdzRXZW1DaUNuYUFkVGNvMHlmazY4aU5jaVhuWWZmUTlFZiswV01GS3Br?=
 =?utf-8?B?SDVabWFGU3VXc3g2UTJXMUR6K0NDa0ZvNE9FU2VqaWJiSHFyWVpkaUFseFda?=
 =?utf-8?B?aExYS2RRZ2VMcUFCdWFQOHJNUEh1OUhwNmdnaHQ3YUJQNjVMVS9YOU9ualVF?=
 =?utf-8?B?ejhVeW5wZ0JGTG1pNUVjSVJvMm5QWnozbUdZczdIRFZOenlhcm1BRVhYUllN?=
 =?utf-8?B?d0ZwNVZjM09BMUN3czdUbkg1dlpjVTJXZDJUMnE2d2gzbHNFN0xRT1dxR0V5?=
 =?utf-8?B?WDBYby8xL1lMbGF5UkN6OHlvc0k0WWx1QU1vZU5PMG0vOUkzdVhEUGVyTW92?=
 =?utf-8?B?UFJzVG5BeUVFQi8wSkdWNmhnenRXeVpRR09Xbkt0bnljM0FQTlFGdCtPTWk3?=
 =?utf-8?B?Q1c5ZlhOcWlHYm50Z2EzNTZubXNURzZhMDZOdUlreDg5ZUJJalNnYzB2WHlz?=
 =?utf-8?B?ZU5Nc2szVE9tVlU1clFGRzZsS0JxS3ZPcUhYclliSWpMMWs3RDNCU1lLWkgv?=
 =?utf-8?B?aDdaSUlJaFFHQ04zcFhZS3ord2FENmVEcDNVQi9jNmZVeW1hUXFJYWlvL3V0?=
 =?utf-8?B?bzNreFBPSXBjdUNUbU96b1VOdVU3UWVqVlNucncxeS9NSHdVVGNzWHV4TTEz?=
 =?utf-8?B?WE1rV283OStjcGUvMWlyQ3RhYmdmVmpCbkxQTUx4bHRPREVSN2ZXQ2N5dmh4?=
 =?utf-8?B?TkZPbHMxUVN2ZHRKenRxM1NFWkYvNWZNR0ZXU2Iwc3VuQkRPZ240N0lXVEJQ?=
 =?utf-8?B?RVlLVjRLM1JGdzZrVm5aTGNIOHlmZ0VIRWVxb0h5d0xXZ0pvbjRvdXVQRG5Q?=
 =?utf-8?B?eXVneDAvV1czQ2JLdEtUemVaNlBTczBoYU9TMUZvbmpudDZFSzk4MVAxYkJa?=
 =?utf-8?B?MW00b1VuVWxnZnhBN0t1MUN1WHU1bHpPTUFBelN6MVFsbHV1SndHRDkxT0dw?=
 =?utf-8?B?Yld0QzN3K2QrQTlEZm1TczRmdGJxVy9iRXZZeEoxMUNZV0VBRlBJYjhGTXNR?=
 =?utf-8?B?YlVtZkIxeW44OGtxS3dBSzduY2FnUkRCL1ZhMFViMFdlS2o2K0c5NHRRN3Mr?=
 =?utf-8?B?YStQWkVUVHUrbWNPZUw0WWU4WEU5LzVib3JwV0FTVDdHTVJDLzZ3S1gzVXMw?=
 =?utf-8?B?REhEK2RaTEtQNVNoUys3TlUweHpBb3pkVFp3U0YvSkNYTWpYbmRRdDBBWDNW?=
 =?utf-8?B?Y0ZOOHAraGlpcGxna1lQa1h2a3lUdHFwVGNvRmFCSlZKT2dDUjhLQWRxOC93?=
 =?utf-8?B?R1ZLTktoSlRUcENYYWdDSkthWkE2RFNQTkt3cGE5SCtmTlJNLzJhbE9CdjJG?=
 =?utf-8?B?MlNld3JNZjZTTmVFcUdMc2NoMmdXbGdScytab041Q0oyWVNEU2VnYXNZc3ZQ?=
 =?utf-8?B?UjR0c1JneGxXSWdKOER2Z2hmUitmeXhwR3FHbHV1NFJtd0ZUNDBMdnZndUFi?=
 =?utf-8?B?alBWUCtLUHNsc3pjb1ptVGF4NzMwalk1cThMenN2R0FZZFI3UWpJWFJRUzNt?=
 =?utf-8?B?Z2dMb2h1QWpiU25SdXgvRG84OEpzbENHZGRrY0xteGVSSE9LNkR2RXlCQU95?=
 =?utf-8?B?ZUFDdFcyOERoU0doaHloa3BTazBPUmVKZXhOSTllUThQSEppK1NROFNOY2Fy?=
 =?utf-8?B?VFZib3JZQjVrdTVEV08zMVlxbElNMWk1NzVPWnE5bGhMYlFTK0lXZFowYXhH?=
 =?utf-8?B?VnpKZlE1eHJxeU9QUDQ0WS9lR3BVKzlyalMweUxXdDJnakp0QklLQ0l6UElT?=
 =?utf-8?B?Qm5OZ3owSmFYUUhzU2lqaWtyM2J2cVRSYVlPLytuT2NXU3Ztd2tZaDFvYldy?=
 =?utf-8?B?bWEwWDRhNjBpbGFJd2tnUzFvSC9ZOUVMaFAybUhyOXhVWldLd3ZwOGVyZ211?=
 =?utf-8?Q?WwK2N8W9h/rqKNRkWNWWNMAOw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7137A57084D3AC45ADD5DE0EA1C124F2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dGxHL1BJYnR6UGNyd0d1aWFicVpBR3BSR1hTeFkrVVBSb1NYWDJ6MUtJTDFW?=
 =?utf-8?B?c3J0cHA0SkVUcGJPcXZLd2lOWTQrSmtXZEo3QlJuNFZPWXdpNm4rR0dmcmVG?=
 =?utf-8?B?b202WS9Qcjh2bFl5VjB6a3BRRVViSktTSEh0Y2tlZ3Y3QWdSUEZJNXFWbWg4?=
 =?utf-8?B?aUM0Y2xvVGlXUGszWUdlbW02RERjSXFSN1YzMXJQMUdSQm1LbFNNZjF3ZlBH?=
 =?utf-8?B?OXhHMXF4RDlsMDQwVkZiblZzZUdpL2ZVZ2NWN0ZmeU9vSVNUZ2dLOTIrdytG?=
 =?utf-8?B?am1TTWswajBrK0VCUjRQU2c0S1NLMW13ZER4aTVOeFVZUmt5R1dqdUFGNW1r?=
 =?utf-8?B?UnJaa2w0WnVhM2pWT0wwd2FOYitpNWJ3SWU3M01waGkwZ0VyTU9VeTFlOTFZ?=
 =?utf-8?B?enR4WGJMSEZzdElYNlVadmtwbEs2VDF2YjRXRXJjeGhYOUtmMlM5RWdQdGlE?=
 =?utf-8?B?eUg5ZWZtaDRlU2R1SndhVGM0cGhoN0pPU3o4dHVzUU5IVVEzbUtFWUI5VFRa?=
 =?utf-8?B?QVp2eFJHSHFLMm5QaW15eWVjQ3ZuZ3pNd0xveTdQWHhEMStuMGk4SGZ2SS9i?=
 =?utf-8?B?eG9sdTNxT2hYTjVMNVpvNzZ6M2tjeXVLUSs3YWY2NjRXUG1YWVdMRklvaGxZ?=
 =?utf-8?B?UkZHWFBEbktnVlBGaXBzMG5lTjR3OGtTTlR5Ky9qQ3FnckFuOFkxU2NNZ1N2?=
 =?utf-8?B?Nzg2MXIrdXlZVGxnUWFyU28xUVl2Y0NEbVRhTGRuNnBBblV1YnJLNElPdllp?=
 =?utf-8?B?UFlaTzByS2FYSk5LempReFJTQ2dwR1AwRGJPQ0tMaFBYaEJjOU90OFpDN3lU?=
 =?utf-8?B?K2c4SzFRZ3hKdVJ2cHJRUTNVS095K1FsVmJIKzF0T0VTU0xWWEFVc0pXOWFi?=
 =?utf-8?B?R1ArQzI0UWRISHZlb05JV1RubDZOdm1RNDErRmlWb3lCZTl1aldxbUlhRXlW?=
 =?utf-8?B?QTF6TXdqVGVMek5kRlRBeFpONkVFZGhtejloTmlENnd4Tjl1TEtSd29JcDNn?=
 =?utf-8?B?NVBxcGd2UFRDNVpuMGVmOWJtY0w2RlhhMHVKdjJUc0NQZVFEaUlaNzJhSFQ5?=
 =?utf-8?B?ak1oTmtMT1dGZEJ5VGhJNW10QU53d0xub3FXUHNUaVZLQnN6ems2YUNwcEZ4?=
 =?utf-8?B?M1hxQm5kUlB6Wk91K21JcnF2ZTM4bVNoeFpBcDNENW5CZ3o4Y2R6M1pSQUJj?=
 =?utf-8?B?NGE5QXRYdVFoalJJL1FOMVYxNzNSbnNWTjBxLzRuYWdWa3NuQ1dZRnpocGNU?=
 =?utf-8?B?emNnMDIzUDBPYVpqalp0aDBUUVpkeWtCVzIwdnNxUDIyd3ROdz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd51307c-8a8d-42ad-4223-08db2b44c53c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 02:17:36.9732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5z9MlojpgHie8q9+xiviESVPwJ6xfI4xyJW5q9WeVSehA7020Sdexw6pq9o7H+AyseqkzDN9Lho3/yGZN9ndA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5074
X-Proofpoint-GUID: _FEt2tyG8rRfJ1YBZFKqo8lzPl8ZX_QZ
X-Proofpoint-ORIG-GUID: _FEt2tyG8rRfJ1YBZFKqo8lzPl8ZX_QZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303230015
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMjIsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gV2VkLCBNYXIg
MjIsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+ID4gT24gMjEvMDMvMjAyMyAyMTowNSwg
VGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBNYXIgMjEsIDIwMjMsIFRoaW5oIE5n
dXllbiB3cm90ZToNCj4gPiA+PiBPbiBUdWUsIE1hciAyMSwgMjAyMywgUm9nZXIgUXVhZHJvcyB3
cm90ZToNCj4gPiA+Pj4gSGkgVGhpbmgsDQo+ID4gPj4+DQo+ID4gPj4+IE9uIDIwLzAzLzIwMjMg
MjA6NTIsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+Pj4+IEhpLA0KPiA+ID4+Pj4NCj4gPiA+
Pj4+IE9uIE1vbiwgTWFyIDIwLCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+ID4+Pj4+
IEltcGxlbWVudCAnc25wcyxnYWRnZXQta2VlcC1jb25uZWN0LXN5cy1zbGVlcCcgcHJvcGVydHku
DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBEbyBub3Qgc3RvcCB0aGUgZ2FkZ2V0IGNvbnRyb2xsZXIg
YW5kIGRpc2Nvbm5lY3QgaWYgdGhpcw0KPiA+ID4+Pj4+IHByb3BlcnR5IGlzIHByZXNlbnQgYW5k
IHdlIGFyZSBjb25uZWN0ZWQgdG8gYSBVU0IgSG9zdC4NCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+IFBy
ZXZlbnQgU3lzdGVtIHNsZWVwIGlmIEdhZGdldCBpcyBub3QgaW4gVVNCIHN1c3BlbmQuDQo+ID4g
Pj4+Pj4NCj4gPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAa2Vy
bmVsLm9yZz4NCj4gPiA+Pj4+PiAtLS0NCj4gPiA+Pj4+PiAgZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMgICB8IDI1ICsrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gPiA+Pj4+PiAgZHJpdmVycy91
c2IvZHdjMy9jb3JlLmggICB8ICAyICsrDQo+ID4gPj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gPj4+Pj4gIDMgZmlsZXMg
Y2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPiA+Pj4+Pg0KPiA+
ID4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+ID4gPj4+Pj4gaW5kZXggNDc2YjYzNjE4NTExLi5hNDdiYmFhMjczMDIg
MTAwNjQ0DQo+ID4gPj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+Pj4+
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4+Pj4+IEBAIC0xNTc1LDYgKzE1
NzUsOSBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVjdCBkd2MzICpkd2Mp
DQo+ID4gPj4+Pj4gIAlkd2MtPmRpc19zcGxpdF9xdWlyayA9IGRldmljZV9wcm9wZXJ0eV9yZWFk
X2Jvb2woZGV2LA0KPiA+ID4+Pj4+ICAJCQkJInNucHMsZGlzLXNwbGl0LXF1aXJrIik7DQo+ID4g
Pj4+Pj4gIA0KPiA+ID4+Pj4+ICsJZHdjLT5nYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcCA9
IGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiA+ID4+Pj4+ICsJCQkJInNucHMsZ2Fk
Z2V0LWtlZXAtY29ubmVjdC1zeXMtc2xlZXAiKTsNCj4gPiA+Pj4+PiArDQo+ID4gPj4+Pj4gIAlk
d2MtPmxwbV9ueWV0X3RocmVzaG9sZCA9IGxwbV9ueWV0X3RocmVzaG9sZDsNCj4gPiA+Pj4+PiAg
CWR3Yy0+dHhfZGVfZW1waGFzaXMgPSB0eF9kZV9lbXBoYXNpczsNCj4gPiA+Pj4+PiAgDQo+ID4g
Pj4+Pj4gQEAgLTIwMjcsMTQgKzIwMzAsMjAgQEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29t
bW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ID4gPj4+Pj4gIHsNCj4g
PiA+Pj4+PiAgCXVuc2lnbmVkIGxvbmcJZmxhZ3M7DQo+ID4gPj4+Pj4gIAl1MzIgcmVnOw0KPiA+
ID4+Pj4+ICsJaW50IHJldDsNCj4gPiA+Pj4+PiAgDQo+ID4gPj4+Pj4gIAlzd2l0Y2ggKGR3Yy0+
Y3VycmVudF9kcl9yb2xlKSB7DQo+ID4gPj4+Pj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfREVW
SUNFOg0KPiA+ID4+Pj4+ICAJCWlmIChwbV9ydW50aW1lX3N1c3BlbmRlZChkd2MtPmRldikpDQo+
ID4gPj4+Pj4gIAkJCWJyZWFrOw0KPiA+ID4+Pj4+IC0JCWR3YzNfZ2FkZ2V0X3N1c3BlbmQoZHdj
KTsNCj4gPiA+Pj4+PiArCQlyZXQgPSBkd2MzX2dhZGdldF9zdXNwZW5kKGR3Yyk7DQo+ID4gPj4+
Pj4gKwkJaWYgKHJldCkgew0KPiA+ID4+Pj4+ICsJCQlkZXZfZXJyKGR3Yy0+ZGV2LCAiZ2FkZ2V0
IG5vdCBzdXNwZW5kZWQ6ICVkXG4iLCByZXQpOw0KPiA+ID4+Pj4+ICsJCQlyZXR1cm4gcmV0Ow0K
PiA+ID4+Pj4+ICsJCX0NCj4gPiA+Pj4+PiAgCQlzeW5jaHJvbml6ZV9pcnEoZHdjLT5pcnFfZ2Fk
Z2V0KTsNCj4gPiA+Pj4+PiAtCQlkd2MzX2NvcmVfZXhpdChkd2MpOw0KPiA+ID4+Pj4+ICsJCWlm
KCFkd2MtPmdhZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3NsZWVwKQ0KPiA+ID4+Pj4+ICsJCQlkd2Mz
X2NvcmVfZXhpdChkd2MpOw0KPiA+ID4+Pj4+ICAJCWJyZWFrOw0KPiA+ID4+Pj4+ICAJY2FzZSBE
V0MzX0dDVExfUFJUQ0FQX0hPU1Q6DQo+ID4gPj4+Pj4gIAkJaWYgKCFQTVNHX0lTX0FVVE8obXNn
KSAmJiAhZGV2aWNlX21heV93YWtldXAoZHdjLT5kZXYpKSB7DQo+ID4gPj4+Pj4gQEAgLTIwODgs
MTEgKzIwOTcsMTUgQEAgc3RhdGljIGludCBkd2MzX3Jlc3VtZV9jb21tb24oc3RydWN0IGR3YzMg
KmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gPiA+Pj4+PiAgDQo+ID4gPj4+Pj4gIAlzd2l0Y2gg
KGR3Yy0+Y3VycmVudF9kcl9yb2xlKSB7DQo+ID4gPj4+Pj4gIAljYXNlIERXQzNfR0NUTF9QUlRD
QVBfREVWSUNFOg0KPiA+ID4+Pj4+IC0JCXJldCA9IGR3YzNfY29yZV9pbml0X2Zvcl9yZXN1bWUo
ZHdjKTsNCj4gPiA+Pj4+PiAtCQlpZiAocmV0KQ0KPiA+ID4+Pj4+IC0JCQlyZXR1cm4gcmV0Ow0K
PiA+ID4+Pj4+ICsJCWlmICghZHdjLT5nYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcCkNCj4g
PiA+Pj4+PiArCQl7DQo+ID4gPj4+Pj4gKwkJCXJldCA9IGR3YzNfY29yZV9pbml0X2Zvcl9yZXN1
bWUoZHdjKTsNCj4gPiA+Pj4+PiArCQkJaWYgKHJldCkNCj4gPiA+Pj4+PiArCQkJCXJldHVybiBy
ZXQ7DQo+ID4gPj4+Pj4gKw0KPiA+ID4+Pj4+ICsJCQlkd2MzX3NldF9wcnRjYXAoZHdjLCBEV0Mz
X0dDVExfUFJUQ0FQX0RFVklDRSk7DQo+ID4gPj4+Pj4gKwkJfQ0KPiA+ID4+Pj4+ICANCj4gPiA+
Pj4+PiAtCQlkd2MzX3NldF9wcnRjYXAoZHdjLCBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRSk7DQo+
ID4gPj4+Pj4gIAkJZHdjM19nYWRnZXRfcmVzdW1lKGR3Yyk7DQo+ID4gPj4+Pj4gIAkJYnJlYWs7
DQo+ID4gPj4+Pj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfSE9TVDoNCj4gPiA+Pj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
aA0KPiA+ID4+Pj4+IGluZGV4IDU4MmViZDljZjljMi4uZjg0YmFjODE1YmVkIDEwMDY0NA0KPiA+
ID4+Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gPj4+Pj4gKysrIGIvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPiA+Pj4+PiBAQCAtMTMyOCw2ICsxMzI4LDggQEAgc3Ry
dWN0IGR3YzMgew0KPiA+ID4+Pj4+ICAJdW5zaWduZWQJCWRpc19zcGxpdF9xdWlyazoxOw0KPiA+
ID4+Pj4+ICAJdW5zaWduZWQJCWFzeW5jX2NhbGxiYWNrczoxOw0KPiA+ID4+Pj4+ICANCj4gPiA+
Pj4+PiArCXVuc2lnbmVkCQlnYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcDoxOw0KPiA+ID4+
Pj4+ICsNCj4gPiA+Pj4+PiAgCXUxNgkJCWltb2RfaW50ZXJ2YWw7DQo+ID4gPj4+Pj4gIA0KPiA+
ID4+Pj4+ICAJaW50CQkJbWF4X2NmZ19lcHM7DQo+ID4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gPj4+
Pj4gaW5kZXggM2M2M2ZhOTdhNjgwLi44MDYyZTQ0ZjYzZjYgMTAwNjQ0DQo+ID4gPj4+Pj4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gPiA+Pj4+PiBAQCAtNDU3MiwxMiArNDU3MiwyMyBAQCB2b2lkIGR3
YzNfZ2FkZ2V0X2V4aXQoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+Pj4+PiAgaW50IGR3YzNfZ2Fk
Z2V0X3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+Pj4+PiAgew0KPiA+ID4+Pj4+ICAJ
dW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiA+Pj4+PiArCWludCBsaW5rX3N0YXRlOw0KPiA+ID4+
Pj4+ICANCj4gPiA+Pj4+PiAgCWlmICghZHdjLT5nYWRnZXRfZHJpdmVyKQ0KPiA+ID4+Pj4+ICAJ
CXJldHVybiAwOw0KPiA+ID4+Pj4+ICANCj4gPiA+Pj4+PiAtCWR3YzNfZ2FkZ2V0X3J1bl9zdG9w
KGR3YywgZmFsc2UsIGZhbHNlKTsNCj4gPiA+Pj4+PiArCWlmIChkd2MtPmdhZGdldF9rZWVwX2Nv
bm5lY3Rfc3lzX3NsZWVwICYmIGR3Yy0+Y29ubmVjdGVkKSB7DQo+ID4gPj4+Pj4gKwkJbGlua19z
dGF0ZSA9IGR3YzNfZ2FkZ2V0X2dldF9saW5rX3N0YXRlKGR3Yyk7DQo+ID4gPj4+Pj4gKwkJLyog
UHJldmVudCBQTSBTbGVlcCBpZiBub3QgaW4gVTMvTDIgKi8NCj4gPiA+Pj4+PiArCQlpZiAobGlu
a19zdGF0ZSAhPSBEV0MzX0xJTktfU1RBVEVfVTMpDQo+ID4gPj4+Pj4gKwkJCXJldHVybiAtRUJV
U1k7DQo+ID4gPj4+Pj4gKw0KPiA+ID4+Pj4+ICsJCS8qIGRvbid0IHN0b3AvZGlzY29ubmVjdCAq
Lw0KPiA+ID4+Pj4+ICsJCWR3YzNfZ2FkZ2V0X2Rpc2FibGVfaXJxKGR3Yyk7DQo+ID4gPj4+Pg0K
PiA+ID4+Pj4gV2Ugc2hvdWxkbid0IGRpc2FibGUgZXZlbnQgaW50ZXJydXB0IGhlcmUuIFdoYXQg
d2lsbCBoYXBwZW4gaWYgdGhlDQo+ID4gPj4+DQo+ID4gPj4+IER1ZSB0byBzb21lIHJlYXNvbiwg
aWYgSSBkb24ndCBkaXNhYmxlIHRoZSBldmVudCBpbnRlcnJ1cHRzIGhlcmUgdGhlbg0KPiA+ID4+
PiBhZnRlciBVU0IgcmVzdW1lIHRoZSBVU0IgY29udHJvbGxlciBpcyBtYWxmdW5jdGlvbmluZy4N
Cj4gPiA+Pj4gSXQgbm8gbG9uZ2VyIHJlc3BvbmRzIHRvIGFueSByZXF1ZXN0cyBmcm9tIEhvc3Qu
DQo+ID4gPj4NCj4gPiA+PiBZb3Ugc2hvdWxkIGxvb2sgaW50byB0aGlzLiBUaGVzZSBldmVudHMg
YXJlIGltcG9ydGFudCBhcyB0aGV5IGNhbiB0ZWxsDQo+ID4gPj4gd2hldGhlciB0aGUgaG9zdCBp
bml0aWF0ZXMgcmVzdW1lLg0KPiA+ID4+DQo+ID4gPj4+DQo+ID4gPj4+PiBkZXZpY2UgaXMgZGlz
Y29ubmVjdGVkIGFuZCByZWNvbm5lY3QgdG8gdGhlIGhvc3Qgd2hpbGUgdGhlIGRldmljZSBpcw0K
PiA+ID4+Pj4gc3RpbGwgaW4gc3lzdGVtIHN1c3BlbmQ/IFRoZSBob3N0IHdvdWxkIG5vdCBiZSBh
YmxlIHRvIGNvbW11bmljYXRlIHdpdGgNCj4gPiA+Pj4+IHRoZSBkZXZpY2UgdGhlbi4NCj4gPiA+
Pj4NCj4gPiA+Pj4gSW4gdGhlIFRJIHBsYXRmb3JtLCBUaGUgc3lzdGVtIGlzIHdva2VuIHVwIG9u
IGFueSBWQlVTL2xpbmVzdGF0ZSBjaGFuZ2UNCj4gPiA+Pj4gYW5kIGluIGR3YzNfZ2FkZ2V0X3Jl
c3VtZSB3ZSBlbmFibGUgdGhlIGV2ZW50cyBhZ2FpbiBhbmQgY2hlY2sgZm9yIHBlbmRpbmcNCj4g
PiA+Pj4gZXZlbnRzLiBJcyBpdCBwb2ludGxlc3MgdG8gY2hlY2sgZm9yIHBlbmRpbmcgZXZlbnRz
IHRoZXJlPw0KPiA+ID4+Pg0KPiA+ID4+DQo+ID4gPj4gSXQgc2VlbXMgZnJhZ2lsZSBmb3IgdGhl
IGltcGxlbWVudGF0aW9uIHRvIGJlIGRlcGVuZGVudCBvbiBwbGF0Zm9ybQ0KPiA+ID4+IHNwZWNp
ZmljIGZlYXR1cmUgcmlnaHQ/DQo+ID4gPj4NCj4gPiA+PiBBbHNvLCB3aGF0IHdpbGwgaGFwcGVu
IGluIGEgdHlwaWNhbCBjYXNlIHdoZW4gdGhlIGhvc3QgcHV0cyB0aGUgZGV2aWNlDQo+ID4gPj4g
aW4gc3VzcGVuZCBhbmQgaW5pdGlhdGVzIHJlc3VtZSB3aGlsZSB0aGUgZGV2aWNlIGlzIGluIHN5
c3RlbSBzdXNwZW5kDQo+ID4gPj4gKGFuZCBzdGF5IGluIHN1c3BlbmQgb3ZlciBhIHBlcmlvZCBv
ZiB0aW1lKT8gVGhlcmUgaXMgbm8gVkJVUyBjaGFuZ2UuDQo+ID4gPj4gVGhlcmUgd2lsbCBiZSBw
cm9ibGVtIGlmIGhvc3QgZGV0ZWN0cyBubyByZXNwb25zZSBmcm9tIGRldmljZSBpbiB0aW1lLg0K
PiA+ID4+DQo+ID4gPj4gRG9uJ3Qgd2UgbmVlZCB0aGVzZSBldmVudHMgdG8gd2FrZXVwIHRoZSBk
ZXZpY2U/DQo+ID4gDQo+ID4gVGhhdCdzIHdoeSB0aGUgVEkgaW1wbGVtZW50YXRpb24gaGFzIGxp
bmUtc3RhdGUgY2hhbmdlIGRldGVjdGlvbiB0bw0KPiA+IGRldGVjdCBhIFVTQiByZXN1bWUuIFdl
IGFyZSBkb2luZyBhIG91dC1vZi1iYW5kIHdha2UtdXAuIFRoZSB3YWtlIHVwDQo+ID4gZXZlbnRz
IGFyZSBjb25maWd1cmVkIGluIHRoZSB3cmFwcGVyIGRyaXZlciAoZHdjMy1hbTYyLmMpLg0KPiA+
IA0KPiA+IERvIHlvdSBrbm93IG9mIGFueSBkd2MzIGltcGxlbWVudGF0aW9uIHRoYXQgdXNlcyBp
bi1iYW5kIG1lY2hhbmlzbQ0KPiA+IHRvIHdha2UgdXAgdGhlIFN5c3RlbS4gaS5lLiBpdCByZWxp
ZXMgb24gZXZlbnRzIGVuYWJsZWQgaW4gREVWVEVOIHJlZ2lzdGVyPw0KPiA+IA0KPiANCj4gV2Ug
cmVseSBvbiBQTUUuIFRoZSBQTUUgaXMgZ2VuZXJhdGVkIGZyb20gdGhlIFBNVSBvZiB0aGUgdXNi
IGNvbnRyb2xsZXINCj4gd2hlbiBpdCBkZXRlY3RzIGEgcmVzdW1lLiBJZiB5b3VyIHBsYXRmb3Jt
IHN1cHBvcnRzIGhpYmVybmF0aW9uIGFuZCBpZg0KPiB0aGUgcmVzdW1lIHNpZ25hbCBpcyBjb25u
ZWN0ZWQgdG8gdGhlIGxvd2VyIGxheWVyIHBvd2VyIG1hbmFnZXIgb2YgeW91cg0KPiBkZXZpY2Us
IHRoZW4geW91IGNhbiB3YWtldXAgdGhlIHN5c3RlbSBvbmUgbGV2ZWwgYXQgYSB0aW1lLiBGb3Ig
ZXhhbXBsZSwNCj4gaWYgeW91ciBkZXZpY2UgaXMgYSBwY2kgZGV2aWNlLCB0aGF0IHdha2V1cCBz
aWduYWwgd291bGQgdGllIHRvIHRoZSBwY2kNCj4gcG93ZXIgbWFuYWdlciwgd2FraW5nIHVwIHRo
ZSBwY2kgbGF5ZXIgYmVmb3JlIHdha2luZyB1cCB0aGUgY29yZSBvZiB0aGUNCj4gdXNiIGNvbnRy
b2xsZXIuIFRoYXQncyBob3cgdGhlIGhvc3Qgd2FrZXMgdXAgdGhlIGhvc3Qgc3lzdGVtIChlLmcu
IGZyb20NCj4gcmVtb3RlIHdha2V1cCkuIEZvciB0aGlzIHRvIHdvcmssIHdlIGV4cGVjdCBzb21l
dGhpbmcgc2ltaWxhciBvbiB0aGUNCj4gZGV2aWNlIHNpZGUuDQo+IA0KPiA+ID4+DQo+ID4gPiAN
Cj4gPiA+IFdlIG1heSBub3QgYmUgYWJsZSB0byBzdXNwZW5kIGV2ZXJ5dGhpbmcgaW4gc3lzdGVt
IHN1c3BlbmQgZm9yIHRoaXMNCj4gPiA+IGNhc2UuIEknbSB0aGlua2luZyBvZiB0cmVhdGluZyB0
aGVzZSBldmVudHMgYXMgaWYgdGhleSBhcmUgUE1FIHRvIHdha2V1cA0KPiA+ID4gdGhlIGRldmlj
ZSwgYnV0IHRoZXkgYXJlIG5vdCB0aGUgc2FtZS4gSXQgbWF5IG5vdCBiZSBzaW1wbGUgdG8gaGFu
ZGxlDQo+ID4gPiB0aGlzLiBUaGUgbG93ZXIgbGF5ZXJzIG1heSBuZWVkIHRvIHN0YXkgYXdha2Ug
Zm9yIHRoZSBkd2MzIHRvIGhhbmRsZQ0KPiA+ID4gdGhlc2UgZXZlbnRzLiBIbS4uLiBpdCBnZXRz
IGEgYml0IGNvbXBsaWNhdGVkLg0KPiA+IA0KPiA+IEFzIHdlIGFyZSBnb2luZyBpbnRvIHN1c3Bl
bmQsIHdlIGFyZSBub3QgcmVhbGx5IGluIGEgcG9zaXRpb24gdG8gaGFuZGxlIGFueQ0KPiA+IChE
RVZURU4pIGV2ZW50cyB0aWxsIHdlIGhhdmUgZnVsbHkgcmVzdW1lZC4NCj4gPiBTbyB5ZXMsIHdl
IG5lZWQgdG8gcmVseSBvbiBwbGF0Zm9ybSBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbiB0byB3YWtl
DQo+ID4gdGhlIFN5c3RlbSBvbiBhbnkgVVNCIGV2ZW50Lg0KPiA+IA0KPiANCj4gWW91IG1heSBi
ZSBhYmxlIHRvIGRldGVjdCB2YnVzIGNoYW5nZSB0aHJvdWdoIHRoZSBjb25uZWN0b3IgY29udHJv
bGxlci4NCj4gSG93ZXZlciwgdGhlIHVzYiBjb250cm9sbGVyIGlzIHRoZSBvbmUgdGhhdCBkZXRl
Y3RzIGhvc3QgcmVzdW1lLiBXaGF0DQo+IHBsYXRmb3JtIHNwZWNpZmljIGltcGxlbWVudGF0aW9u
IGRvIHlvdSBoYXZlIG91dHNpZGUgb2YgdGhlIHVzYg0KPiBjb250cm9sbGVyIGRvIHlvdSBoYXZl
IHRvIGdldCBhcm91bmQgdGhhdD8NCj4gDQo+IEknbSBub3Qgc3VyZSBpZiB5b3VyIHBsYXRmb3Jt
IHN1cHBvcnRzIGhpYmVybmF0aW9uIG9yIGlmIHRoZSBQTUUgc2lnbmFsDQo+IG9uIHlvdXIgcGxh
dGZvcm0gY2FuIHdha2V1cCB0aGUgc3lzdGVtLCBidXQgY3VycmVudGx5IGR3YzMgZHJpdmVyDQo+
IGRvZXNuJ3QgaGFuZGxlIGhpYmVybmF0aW9uIChkZXZpY2Ugc2lkZSkuIElmIHRoZXJlJ3Mgbm8g
aGliZXJuYXRpb24sDQo+IHRoZXJlJ3Mgbm8gUE1FLg0KPiANCg0KQWN0dWFsbHksIEkgdGhpbmsg
dGhlIGR3YzMgY29yZSBpcyBzdGlsbCBvbiBkdXJpbmcgc3lzdGVtIHN1c3BlbmQgZm9yDQp5b3Ug
cmlnaHQ/IFRoZW4gSSB0aGluayB3ZSBjYW4gdXNlIHRoZSB3YWtldXAgZXZlbnQgdG8gd2FrZXVw
IHN5c3RlbQ0Kc3VzcGVuZCBvbiBob3N0IHJlc3VtZT8gWW91IGNhbiBpZ25vcmUgYWJvdXQgUE1F
IGluIHRoaXMgY2FzZS4gWW91IG1heQ0KbmVlZCB0byBsb29rIGludG8gd2hhdCBuZWVkcyBzdGF5
IGF3YWtlIHRvIGFsbG93IGZvciBoYW5kbGluZyBvZiB0aGUNCmR3YzMgZXZlbnQuDQoNCkJSLA0K
VGhpbmgNCg==
