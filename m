Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFFE6C84F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCXS3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCXS3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:29:21 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376AC15C8F;
        Fri, 24 Mar 2023 11:29:19 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ODe7aM005627;
        Fri, 24 Mar 2023 11:29:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=jbOvvn4GniAPQ7XbiLNcjCPkKMDfm/16WkGvzan24ZY=;
 b=NNnqhXFsMXnysQLIiCHNh2CDY/NgH/4ks+ecdjIMVxeL1++pxJ0Xqm3iLXsXajAVTFKD
 wPME1tqc4uur6ukhLFRgFQIeOs5fG+MlS8RfkAagQ/kLeb7xHRE0p7vS6heEGRJT/pJt
 UL3JJJcIfXHA2gVkqY/1OQwNcpJDV84gjV5FI75ypV5pLJAGaRTaY2CiDZ0jKH6dqne3
 WiKT5s4uIz+EvH9ypWJqExtnabE1pwIwH1MBOl/Z8ioztpTIaSXjgldwYPLeLbd9gj6U
 12SY5jC4hCdknugddGY1UQVvPdTBpXFynWxqmOHIwu2SmWqpKFsain/W/nhShEKp/k6q Kw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pgxtn50as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 11:29:07 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A57DE400E6;
        Fri, 24 Mar 2023 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679682547; bh=jbOvvn4GniAPQ7XbiLNcjCPkKMDfm/16WkGvzan24ZY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cR92uIQ0kxQ2Uui4TPL3rGDhj4DQq8ttjzMBv6ru7YRSgXDi+0JEFJDI1KJtJi7YS
         87JrC2//ULES30SJYNr1IvxRs1zZupL/8ufaujMSTgnwLCWQAOvVCDEXiqmCZMPi/s
         9L7N+ZPcUMFFTlqs284uP2gWsAAy8SJTA7RdTchEn4fOI1vUwa4X7lm5dDhbqZtwIb
         d6hLD/GBftHq0uycdTdTosMNvf3HfBTKe0zPcd88XmVOjAV0ide0ePiHd4LQpBCVQM
         WlsQOQohavWJ6za29Yn6Hy0wyU+IFjfJ9peW78O/1aoLULRe4KnG6EoyTrAMsKnSxd
         WA/f2JdySESOw==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5E7DBA0062;
        Fri, 24 Mar 2023 18:29:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7C617A0052;
        Fri, 24 Mar 2023 18:29:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="w0JsTMd4";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8+jyLKY6pwzgxr/PBxG6V1mcKuSNJHRqZi7GSK366nrFaPLZvCea5izzs3MXzfTG1oitR0jn4KY08dvXQLSoZ91oQp5Z47+I859yaglD29uzUfS+scWocPisYTqEtg8mQA4EWRTxA4SoMKMZLXmXTuf0hXkYqUgrdUvMJf5Q/NoMOWqYEOJJxUgkvod85l4e0vCZ2AlJuu9IsYps/EwzM+Z88IUHZO390IGo1TkItwpnCE1pshHsz6xxInzrdFqBWJNKw+fvhk8ALMvPArR026OudIcETmKNwj6+ok8CGX1uJJQSSuqnAcKV8pISIBZP9O2w2ErGT7PnLmRgVBiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbOvvn4GniAPQ7XbiLNcjCPkKMDfm/16WkGvzan24ZY=;
 b=P0oxBLbJqK/iDeN/2B+aRehsfONFb/aeEBPPWRL60eOblkCS/Ix6+Kk+jNYTcUZKg1pH+331aR6cmsOAf3dAEG2nGHzHdLsTQzO1QeShfO4SDSUEHwQ7IOQsWgz43v64ixqhdMbOVYFue/OYSDlzTryir2cuELKy9gtTypbeUmaLTVLJbW+5TCRXpmE4E08Nc3OPwANhH8QDPbPEerURyeRUmRqm7COuUtkkYY1bPllLTJzuAXStLBgrn7oezjqaub5BnN07DkLke//8LTtReO7JkV7Q758ehq47SZj4QMpIGSA0Ei3WWumLoqCxbytD+/Qb4BTIVmgHJ88b5janFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbOvvn4GniAPQ7XbiLNcjCPkKMDfm/16WkGvzan24ZY=;
 b=w0JsTMd4vu9afD4BIQS2rue8EZl73QxSy5UdQS8i0GVR7t57Fd5AxygYElaIPya94/9vFLpv2/QWE0ELmRK4wPKqmSShF1ysHbN4EObdbcVJWfHJ5gTuaU3r1dy9g/o/7idWc1UYLaUyq7ntACPvAUg9TpY8jdpQVXgp6u1XqvY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 18:28:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 18:28:56 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     lihuya <lihuya@hust.edu.cn>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "dzm91@hust.edu.cn" <dzm91@hust.edu.cn>,
        "hust-os-kernel-patches@googlegroups.com" 
        <hust-os-kernel-patches@googlegroups.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: remove dead code in dwc3_otg_get_irq
Thread-Topic: [PATCH] usb: dwc3: remove dead code in dwc3_otg_get_irq
Thread-Index: AQHZXUoQTEnv+EhP8EeNzW8XI60tb68KQmSA
Date:   Fri, 24 Mar 2023 18:28:56 +0000
Message-ID: <20230324182853.rbguxi2lng2mhm3s@synopsys.com>
References: <20230323053946.53094-1-lihuya@hust.edu.cn>
In-Reply-To: <20230323053946.53094-1-lihuya@hust.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BN9PR12MB5382:EE_
x-ms-office365-filtering-correlation-id: ea972443-cef9-4d72-f179-08db2c95a11d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8c3XQuIjc9o1i23p6hxtIAckNiWFWKvCsk4QCqudqbfmIsW96mrIc6YBhiTtcuF46IyfcKbAeV6g3XqINZn2a6OWeD8NMxRshow9n9H6npo5LwygEC3/0B4nN2ou4uQU/cmooLwHBxcRp2PCCvsmgoPd4AKZwUOoiKPkOBFYDSmibghZ7PJD0tv77Jiirt+KZbr5ac6EBI1enqwCHrqesTdj+VSvFZteUkLVqRr+o1SonqiFIwN8kIa+NCGoyiK8kJ/gjysfN2GwHF84yhz6R6gJ3FgJTiR54rPjFSwS4ciiJG4H9VLtQbo/ddn5MyyFM7eEGKqWnvFZcjUifn2cSjTCu1YpzuqwrUJ98pf22qcHTaR8qAAS3rC/A/R/H5NsE+c+bcABRzMJbLh+wCjm5FaF3qstbO1FO3MnWR4kJ5hITLObInFW+tKqysrt2gd/h8/XgO1+MLj9DwsVz15+JRN5f8Gw8vWckC1BeLIu/IkQc5WeTgmFVyAPMH3iJE6K2LoHcPkA5SmjvlDyp765ZS4sNYPt3Ijbh7HpHbUe7O6un/bko851OZ0/vYZVGWKY62M4z69Z9mCHOZhyR79MgFQJjyzo0Mc5IGO37SsAxw34xUAERDPTi1OvzzhNpTD98n70v1tiH6/ENsgPoUIYGr+H663MNmz7oWd3pqXsI338IXf7/g8COLvphcNTiFkLrNl0iCyHOfdtwjh3klW7AQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(38070700005)(6506007)(1076003)(26005)(8936002)(6486002)(6512007)(71200400001)(66446008)(316002)(2616005)(186003)(478600001)(86362001)(36756003)(8676002)(66556008)(38100700002)(66476007)(6916009)(64756008)(4326008)(2906002)(41300700001)(5660300002)(122000001)(66946007)(76116006)(4744005)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVNPZE9BTmpyVHo1RGNtdGxtQ0p6ZDdBQmVZbHM0cURKM3FvWVJNbWtKbEox?=
 =?utf-8?B?WjJYdXRqOXBJL2oxUWZDQkR6OVlIQmh4VXRJV1RHQVV6d0plZWYvL3FTNFJY?=
 =?utf-8?B?S3huVVV6ZGV3WVRDenNSdzlJeEQyMEZLTk5JVXJjV3RVRUdIUXkvRTd3VnR0?=
 =?utf-8?B?bGRCRnZBaXdlTEhTYngwNm9MbXFKNENEcWNuNys5UUtObjZrSUFHK1kyMy85?=
 =?utf-8?B?YkNPU0tRRS9MRTN6MTdrNHk4RVRxS0tkVUxNeDBhV0VDNzJVV1VRa2YwTllu?=
 =?utf-8?B?Y0R0WW96VU94SHpoTmZBNkFTWjdOOWtBaFZUblpoaDFiRFlmaGh3ZVBxR2Zk?=
 =?utf-8?B?YSsrYlNnQThQTGx5K0lRTWJ2NjloUkMzRGtMWE16UTU0U1h3MGR0YVpIcThJ?=
 =?utf-8?B?bnJkMlZ4TTFid0ZibVYyR3FFYURpTGV6VkkrbCtScEo2VkxMdCtvTnIrUWxk?=
 =?utf-8?B?c3ZLdnJiRHk5elJTUkhtSXBxY3JpQjVONEVBOXNoSHVXSDVBZXdldjBTekNX?=
 =?utf-8?B?bXgvdSs2eVk4MXFlVWY0RlE5TzBtbjZ2VWRpdEpBTUhTWGF0TEY2Ly9uOWk3?=
 =?utf-8?B?Q0NidGlWV0k0WjBKV29yNDVjOEc2RnRZRUhGTFNmWlJQN2xsSGp4dUI1SE5W?=
 =?utf-8?B?cThYS2drMndIcFpCdTVBbUphSmRRTHY2VGJMc1QydTZ5WStubGVqSXZHNjNB?=
 =?utf-8?B?QTM5OW9JYXlJUE9VNll4QUtXMVRmYmJPNE93dDI1bmRXalRqSzdYelJORXBP?=
 =?utf-8?B?UHgwd1ZYdUNwTDZNQXlnNFpHSXdSUnA1OTBkaVk1WFlhNHJlcFpBdkpKRWVG?=
 =?utf-8?B?WnJ2UFcvRFZiT1ZHeTBVV3hPTFhRMW9lMmVlS1VyTUhDZU1ZeDNzaHJzamZJ?=
 =?utf-8?B?V0Judk93WHZ5TmtENGlPSHdGVzZPRDB6UlpZWWZSUmFDUzcxOFozT0M4aXZq?=
 =?utf-8?B?b1J3bGU1Tk9CanllTVVBY2JyaHpSRjhqck9sZGVMeHhIZWFCSnBJblJRQklG?=
 =?utf-8?B?RzN5R3V5b0V5VlFKRE9CNFgwOWtHSVlIc1NrY3Jveno5UjVzbHdiQ3JvSG9h?=
 =?utf-8?B?aDZWWWI4dlMyNmpkMitFenY1TXNHbFJyTUlldzJtU1RJbjI1YkhNY2hIR1Zr?=
 =?utf-8?B?L0hYOW5VdEhtMWRTblhrSUwrS1B1U3BvLzI3MCt1U2tNYWtKZnRnYWlIN25n?=
 =?utf-8?B?ZFVWWnp6djMybGFONzQ1QVl5TXZTYUpMUitEODlRRzk5M2daUzBtc3VNQ2U1?=
 =?utf-8?B?ZjVmSGFKTmpBSnNib09BeFczYmZsdkFHY1ZaTXN3ekZQUlBpVDA2aGthdWlu?=
 =?utf-8?B?ZTczaWxoWTVDNXVHdkRvQXJlSTZ1N095Ujl1YnUzRGcvd2wvMmhVOFVtVXpW?=
 =?utf-8?B?N1dvaVR6OGJiTjRieXhyWmZjQVhzY0NQQWNMblBlYnNZTzVnQUhOVDd5TzEv?=
 =?utf-8?B?K2VsdEpLSjIva3F4N0IxUXhpRE1sYzFSZUNnZGUyVVR0R3ZIaFhGOUdvdUlG?=
 =?utf-8?B?WWxLdXRHeXdHY1Mxb1ZVekJKM2pvaFJIa3ZlZU5US0svcHpMY1gzeENRZlhW?=
 =?utf-8?B?OTdjQmU1OXJFa0VESkxkZ04rTHpURnlyQlpPWWIwL2RzbnEwbWRKZlNJUiti?=
 =?utf-8?B?UytZdHo5MXhJMTJ5c3B1bm9nMzdMOURlVHpyYTFxWnpvTE9nVjVjV2RxRDlZ?=
 =?utf-8?B?dmNWUER5UnhUaWpQN05nakxEM3NVVjh6QklEMTlsakhwMUJFL0l5aGZOZGdW?=
 =?utf-8?B?dTlJVjdXSlVmcFNkRm1TdVhiWE9ac0xGdVo0YlJpQXNuSnhHdEVwVjZtK01k?=
 =?utf-8?B?RUh0QlN6bmpHa3lxN2dnRCtGUlM3bHA4Rno0TnlocjQ2Qlh1OWgvaThrWnlj?=
 =?utf-8?B?UUdGUUd4dnYxZnpaWWlXS3JOdEEvUFhRSlNYeU1Fc3JIVlhRWE42cGE2THhP?=
 =?utf-8?B?VjRqMDNORHVXRHdvYmR4WjZLYlNHalBiNUVjU3VabGgySGNaZFBOS2ZkTDUw?=
 =?utf-8?B?ZTJhV0FnUXBGS2F5bFZrYldzL2NrRC9pNlVvUEVlMFZsRmZzQ3BzWVVVMUF4?=
 =?utf-8?B?WXhoUmZRSzFaQjVaNUdJN2l3elN0dmx3Mkg5RHFLMU85QzBCQmZSK1YwNnow?=
 =?utf-8?Q?mfIrgKktArlpfHLkFX5OGHvyE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6070C4AC372F9F43A01B3505CC12A0E1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZmlORzhSZHE5RzVUd0tJdUFJODVvZlJndzNwbE9QUkFnd2RuYkFmdlp6aFpO?=
 =?utf-8?B?OEYxbk9wZmVHS0w2QzM4MDZueWEwZjF3S3B2TlhINnBSTE1qaXE4V3N4d1pO?=
 =?utf-8?B?SmN0UVBiYTllTVNJdUxxckhhWDQ4YkZoSGJtVmlLT2FSWlRyUGY1bXF5UVAy?=
 =?utf-8?B?bFpSZU9vaHVxQXVNeENVN29CYmF1bWRseFUrYzh4aHQyV1J2S0dOQmNpVFRn?=
 =?utf-8?B?UHhqcmVGUWtNMHY5SDJrU2NsNGR6TW1RRmFINVNqQ2k3Z0FaQ3lncGtIb1ZH?=
 =?utf-8?B?K0FyNHVxMTZkOTAvSjhzdER6ajh1aDUrNjZ4UWxMMWRWSk9LbFpnd2owNU1V?=
 =?utf-8?B?STdHVHhsU3NMVHBIOGM2Skt4S0FLY1lnbGhNM0pubGN5dkUyM2pvS0FRd24z?=
 =?utf-8?B?MkNRRi9kZDArVnVNVitIRW9NSjZ1akVBbnVUR0UzMlRlbWF2Q3dLS0t4V0VH?=
 =?utf-8?B?U2gvR2lnZXo3dmJBSUIzQTg0MDltZXNzREI4UlY3YlhpSFhXUFhGckFxZUxq?=
 =?utf-8?B?TG1nblF6eVZVMHh0NXo2TU1kZXU4dnVNcjlKaUlrMGFFbnJJMStkb1FkQ1Ar?=
 =?utf-8?B?VmE1aDluNXZpeTZXSmFJVWNUamFsT0VQaGo1cDVtRktNWjFGeTZLcUd4QW5u?=
 =?utf-8?B?c3IvMTlCeHI3U0JmOHdwZFNrcUpQZWtrTFVXV3VFbXlHSS82WHI5MFRibEVi?=
 =?utf-8?B?ekdnbnNlMm54cG85aTIzYlU4cTRpd0ZpVU5YWnJjUFcxZC8zNE45KzJwQVdM?=
 =?utf-8?B?SFY4YWpTOTJ5bDdjdWkrOUVGeldEUm9QUktvVVlBMUduaWNMejBwYVlzb1A1?=
 =?utf-8?B?WGRrSEw2WkloMUlDVXI0bUthV05MZjFVVm1aNUZnWmNIMjVzNExMUnNURjli?=
 =?utf-8?B?WElnT0ZQdVFWZHpFSGVkMzRLUVlVQXVKV3FLV2wyN2Z6NlVpUTJWK3BPQVRa?=
 =?utf-8?B?b3BUVm5pRmxoamRJWXZqdG9EalVRclVCcXlYYlB1MlJMb1d2TmF2S3YyWHJz?=
 =?utf-8?B?SjRQZEd2NVFMc2cvREluRU10dUxVOVhicDJjTGphYTczMVlld1YwRG9XSVdj?=
 =?utf-8?B?UW9mTnhkK2I1OUV4NFRQRkNmOFVzS1JoRHo5VzVSNXRuY0ZJVldKQitUREwv?=
 =?utf-8?B?dUY0dTNyWndwckZOdlh3Z283TnpZWDI0aEFSeU4vTlRDSVlYVUlOc1VIT1Jq?=
 =?utf-8?B?RFl1ak9HU2JIRlRyS0NKS3BicHRGdnBwYW1EdWYvK0VweXdUb2NCWHhQNE42?=
 =?utf-8?Q?54Nffpf82Mo5dhA?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea972443-cef9-4d72-f179-08db2c95a11d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 18:28:56.7744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7uRCvOY2Tx+T+ky4bY7Q4eYgppIJTHDFnhj9L8DGUNCKM4vKqMHNJLeuJ/D8e2ObLRUdie4yMwEjn0Wopv18Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5382
X-Proofpoint-ORIG-GUID: SqOh82PAeNtsJjbk-dgOmWrdZO7WO9eS
X-Proofpoint-GUID: SqOh82PAeNtsJjbk-dgOmWrdZO7WO9eS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 clxscore=1011 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=893 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303240145
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXIgMjMsIDIwMjMsIGxpaHV5YSB3cm90ZToNCj4gcGxhdGZvcm1fZ2V0X2lycSgp
IG9ubHkgcmV0dXJuIG5vbi16ZXJvIGlycSBudW1iZXIgb24gc3VjY2Vzcywgb3INCj4gbmVnYXRp
dmUgZXJyb3IgbnVtYmVyIG9uIGZhaWx1cmUuDQo+IA0KPiBUaGVyZSBpcyBubyBuZWVkIHRvIGNo
ZWNrIHRoZSByZXR1cm4gdmFsdWUgb2YgcGxhdGZvcm1fZ2V0X2lycSgpDQo+IHRvIGRldGVybWlu
ZSB0aGUgcmV0dXJuIHZhbHVlIG9mIGR3YzNfb3RnX2dldF9pcnEoKSwgcmVtb3ZpbmcNCj4gdGhl
bSB0byBzb2x2ZSB0aGlzIHByb2JsZW0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBsaWh1eWEgPGxp
aHV5YUBodXN0LmVkdS5jbj4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2RyZC5jIHwgNSAt
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMy9kcmQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHJkLmMNCj4gaW5k
ZXggMDM5YmYyNDE3NjlhLi5jMmUwOTcwMDIxMmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvZHJkLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kcmQuYw0KPiBAQCAtMTU0LDEx
ICsxNTQsNiBAQCBzdGF0aWMgaW50IGR3YzNfb3RnX2dldF9pcnEoc3RydWN0IGR3YzMgKmR3YykN
Cj4gIAkJZ290byBvdXQ7DQo+ICANCj4gIAlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKGR3YzNfcGRl
diwgMCk7DQo+IC0JaWYgKGlycSA+IDApDQo+IC0JCWdvdG8gb3V0Ow0KPiAtDQo+IC0JaWYgKCFp
cnEpDQo+IC0JCWlycSA9IC1FSU5WQUw7DQo+ICANCj4gIG91dDoNCj4gIAlyZXR1cm4gaXJxOw0K
PiAtLSANCj4gMi4zNC4xDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5
ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==
