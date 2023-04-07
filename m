Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292D86DA6C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 03:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbjDGBAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 21:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjDGBAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:00:40 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9172727;
        Thu,  6 Apr 2023 18:00:39 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336N02Ne022959;
        Thu, 6 Apr 2023 18:00:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=5O0EdndITorDT4U4iA5G4cfFuXz1/E2+KR3RE5bw3PY=;
 b=QiXmh5HAcnsqwYE6fcw9Tzf6PBYRvlRDIeCrL1zzq2P6dknJuS6kmxvB0jWhDo3n8uUQ
 uogymQxNX4QFcAm12SPdixIGCN7MiNrvJfyZpVG6wORpA4t6xS80ZpuuzXNWktieJPxF
 aH5DaeuhpM+2aijeTmRZBWtzJIjYF5SxkrkPE9xBtxP0fH4WzI9KfFTtuD4P5ehD8HUY
 20Nn9Rj9iRsBJCDlz288HJPcEIOPe/bp8WtZ53IsNy2YhmZASJPEIPeR5rBAeQRAIyfO
 xuCr0P56s/xJGhfii7TkbeFZAIBKpCS7TLaoCr/UEWfc2K8EmLfdfjDt+N6kOWQZybc8 Zw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkv9ekke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 18:00:34 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3767AC04C2;
        Fri,  7 Apr 2023 01:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680829234; bh=5O0EdndITorDT4U4iA5G4cfFuXz1/E2+KR3RE5bw3PY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RTZFaBRwWCSp3B4USZu6EyYcXnQ60/wa1gvwjVkfQYisOwDAJ/NrNULohfCBScB2v
         G6yE6cYnpRh+1iUYrbkN31cfIVocX7WUtJX48gH29XXSCQugUwfjpdOqSo/uPVbXYl
         +6+hbiv70RCpgz3S6JUAokE0Jc0GoUlv3KWyMZcfH8MYm3rJ1BLsLl842mR1s2Ao+B
         LxLGO2HsKSvmdImE8tPR7I4AYciEoL3AXj+V49kQocbgyyc56beNa+8A4aB/+w21Ce
         2FuqvZ4yPStmhnsHCl/I1H7wBpwI0ZcCkzwx836gVv6WSh/JdvsvHi0iWN8lnz7de1
         mHV46zBeFkPtw==
Received: from o365relayqa-in.synopsys.com (unknown [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relayqa-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DB659A008A;
        Fri,  7 Apr 2023 01:00:33 +0000 (UTC)
Authentication-Results: o365relayqa-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=chGDwycq;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relayqa-in.synopsys.com (Postfix) with ESMTPS id 1E0C3227914;
        Fri,  7 Apr 2023 01:00:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0vb24YpcMy/nyJx5kSYOMyRzzItcSUv1vgJQ2ZtGHW3D53KreATT4tKilABCsFhdT4apAJ6rve4mNymDdiR23Vom8EE0v54LT89X12OQEumzVvEicQv5QS7AcA02ErNeKV0rJKj9BVyK0GrI78EQfAX6wy33N3NWcEWQPIFnNwIZgUMmy3M2/aFclmbv2PpBhvsp35sdCsVpfuu4ELcCpZ0rHDR5wA8DTkzicLDvz0XwTqdG60ssR0ZDET5DgYAdgeLgu1vXiNInaiMPOUQ04OVWtjeAPjVa1Z6RmpXJHyjASe1YFHTa4vBUScI5b5MJ9Avgtf0RZ9219IO8Hsr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O0EdndITorDT4U4iA5G4cfFuXz1/E2+KR3RE5bw3PY=;
 b=NLn31VOZ0B3g1AMNy5pWZvG7L4DqSSOzyWd4sqyll4zfmuCGZUbTkO0euUdVcuLO9kM5Dbcd/Bpi1vP539B5kX7Zfc5IHEisARMkeZ6cz1OQKVo+ICPTiWvSwOKwMl3EvmwcvJQbhWTyN46FODPt1Zc/vD3AHNJ0IwMIwoOEjEJMRgDSudao7EFNtAKnk/sYreWgg1YrWERgn/LJwq8b3TnV54UABd6sJYH7ABHJsMhRV9h31wo2bJbI2thU8y7mKSyAzpITAKwutOKsxx2qioc0OieedflBEzOMB8hscRWuR9DJs0M9vySdjL/P9c59ECAiXDWyf+5U839kTcfLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O0EdndITorDT4U4iA5G4cfFuXz1/E2+KR3RE5bw3PY=;
 b=chGDwycqHiaiW4dqCH3RZSuSGq16e0GodOuaYV3g+2uggJHHmwW9CNiL04C/5zuciGN/DJVY58EN9DL6un7sWcSUoj2MJWGFV4CvXRgbiWwzc7AVc1v2by1OsCGEYw+ZZPtcp2Dcrl3hkjh4sHe9diN92zs4WjegiY0DrPaHJxA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Fri, 7 Apr
 2023 01:00:30 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 01:00:30 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/11] USB: dwc3: clean up phy init error handling
Thread-Topic: [PATCH 07/11] USB: dwc3: clean up phy init error handling
Thread-Index: AQHZZsav1RK3X9oK2kqAW9YXrauQUa8fCxQA
Date:   Fri, 7 Apr 2023 01:00:29 +0000
Message-ID: <20230407010016.sqbxmjyegpwai7p6@synopsys.com>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
 <20230404072524.19014-8-johan+linaro@kernel.org>
In-Reply-To: <20230404072524.19014-8-johan+linaro@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB8244:EE_
x-ms-office365-filtering-correlation-id: c8731dba-162c-45a7-91da-08db37037b86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ml22dJQvAScQneyOlM2PZiTFh79Imae52vOofIDh6CE/xkNEexWQH3IwRqdpQCMN2yEMqDayVjyL5LcfCnYslUiVoCbcruTsETPEhZRtsNqyppLXf0982CRJsQrUJcrrfHzvhz8CRdx1STsXVjOkoMSUow1gpUPnONNSG7Yyu7rGFepEa8a1LVPJNf4ZiJqr/OD5nQryiimvZvxI7UOY+E4w6kuaGIsw7gn0VgfB/Jmhg3Tby+adWPsPlnSMFiEG7hoFV6xgENA+W7ySrP29QeK9VaFq9bMnPqvEK9y7cnzxkRyB2S/KzIdA1pEjmacTCqRJVrXj2hFzVz+ZmpxExmTbOJ/eVwdaYcXVoEKbsfb4jX131bp+ND9Dx+kMNVIiHBRcI4/2U2eKQaF2Y6LupMdJv4FZ4UzqXckvy7nK6fR0J7G3naTAtQwoNlQ4I45blr4PxTfb+aIILO7JUODN6Rc7LCIaVN/EATj1fHl67jIluhAGfh0HEuHYsbQro9ntDDHveb5rPYj2o4i4pfkyFXWNzjnjMLCmnN5jtMmkTVYvT31xecLsujMOOgyqV2MyBIw8H+nQWqDw10hB1CFhCixATmu9kQGlMxIK9V9oWZ/7K7JGBktzy9HIx+PFXitv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(2906002)(66476007)(38100700002)(122000001)(5660300002)(66556008)(54906003)(38070700005)(66446008)(8936002)(64756008)(76116006)(4326008)(66946007)(41300700001)(8676002)(1076003)(316002)(36756003)(83380400001)(2616005)(6506007)(6512007)(26005)(186003)(478600001)(71200400001)(86362001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3BjL1U2a1RGUXRBNHVNVnpCSlpBMmJGVzc3amRxVEwzRDBhekZnWGtxdVpw?=
 =?utf-8?B?RzZOUVZlTnkzc1p1RHlnY0NOSzRhdG1sTElOczdYajlnLzBZWmdoNk5ISnVp?=
 =?utf-8?B?MnNmemlKWStEajN4N1ZBT3E1YTVHeWU1Z2d4QW4zaHhhaElCQ0pEZGxha1BJ?=
 =?utf-8?B?eTZXU0VpZHdHWjJUT1ZjeStNbWh3ZnBQdk83UXUyVU1ZVEJJUnk0SHNvdG10?=
 =?utf-8?B?TUh5NDRtU1dFWjJHQ0JUcEhrVTdGci9oZ3pNZnFaL01CanZQQ3owT0ZodlJi?=
 =?utf-8?B?QzR2UTUzcDgyNnlGcFRaN2hmTmZTcUhtN0Q1VS82andYdUxkVkhZWEgycDRq?=
 =?utf-8?B?dVhhdFVvTFFiTE5TWmpyQnk5emowNTlNU001NGJkckZjVzBIQjZDSE9aS0g3?=
 =?utf-8?B?NlA0cXNCK24rT3FjSTlEL09yS2pNOVNEc0Y3WUlSODdkWVp3VUJNaDZFUEh2?=
 =?utf-8?B?Z2F2QUQ5eXVpb2pwVkRpemdkREhPVFhJdms3THdGaDkwVENsZU1IMDUvTm1V?=
 =?utf-8?B?UlAzTTA3OG9ndGhwMXlFRzFPWXZvTkk0RHNvY0lEOFhEbjgrS3ZVSTZxSkhu?=
 =?utf-8?B?cFVRaU5IUUlPNVJGcHlHZmZ2RlZCa21nMFhoZERsc0FXa3N0ZkdBaU5kTk9z?=
 =?utf-8?B?TTFsM2NTZVNkVGwrekxYS054czhpeTVGSld1cmdRbzRzdmNNN094QU1tYjBX?=
 =?utf-8?B?OUxleDZMcDlDK214dW1jY0NzRGNTRTc4UTdXVCt5MUZnK2tSamZmUG5jbnls?=
 =?utf-8?B?RTBFOThZSnUydDRWbmNMTHR0OEE4V3dLNUVJZGRyLys3elQwcXVvTFZZcnNZ?=
 =?utf-8?B?eGlZYWF4MXpOZUd6Q0pKTDhJaUtjYnN2Q0FHVVQyUjdVYW95VUtlSjdHS3Zp?=
 =?utf-8?B?RVU1U082N1ErQ1FhTWVoY3IwdjgxS1RnMFBNRU1pR2k3SDZ1L0E0dk1oSUxR?=
 =?utf-8?B?VkVTWExlaURuZ094Tzc1RVhWa2tjVGNVNk9uZnpTT1h1MUwzZS9GUDg2dkRB?=
 =?utf-8?B?MWNFU3AxYWpKREZWZkFWbVlZampmSXRpVCtHRDZKdDV2WFU2cVFlRjkzSkJE?=
 =?utf-8?B?aXpXdWxaOTFZc2dvRFpKVkVaOEVTTTh6WGNVU0lPTnNMUjUvMFZWbGFQYTla?=
 =?utf-8?B?TVNIY2pDUTZFK1JWNVJCcS9LRzhtZG83bDJyck5xNW02b296SFlPTjhDRDUw?=
 =?utf-8?B?NzI5UzF0Y2wrQXg2SVVMSGhzbHNWR2IxKzFpdmhUZCtFVG5yYW8rbTNtL3kw?=
 =?utf-8?B?bGcrSyt6MjI1a0FOMytHVFhjSHFhY2o5QnVOKzJTTkpFSEdIYW16NzdnQVpL?=
 =?utf-8?B?L1c2Tm1qWmFuTVdvZTZLSU9yTHR3eW0xQXg3ZEFDZVFSL2ZuYmluV0Y4RXFk?=
 =?utf-8?B?OUpMckNyaHIxZFNGaXZad2YrNndzNVVCUXZibUo3MnJEZzZPRXB6TEJqODBh?=
 =?utf-8?B?VEN5b2Q1OG9kNVQ1TTJLTjJvMHBROEFxOC9MdHhBVkpyZ3MvMlArUXBoM095?=
 =?utf-8?B?R1NSVWtRejV4TGZlNXZTa1N4SldHSmhmdnJrL1gra0UwRWpCRW1JY1craUE4?=
 =?utf-8?B?WVBSaEZwNkVRanR3cXRpNkxvM2FSY2ZNYlJyTUpxNFFqQjdnUXFabFRCclQ0?=
 =?utf-8?B?WnMyWnkyVC9jcmVpT0hNTk5aZ3Z6d0xwMDVheW5ZNDFWR0V3MFBpNzdnSTcz?=
 =?utf-8?B?RlNZTGFHV3cvcUp2cnFDb252SVg1ZmVLNEZlbElJUTZlVmJSN290RmxHNFQz?=
 =?utf-8?B?cFlpc1lWekhBV1psRGxvU3J3WlAvYXdCOWJ3ZWN6ajl2dmRjNmNVbksxbkFG?=
 =?utf-8?B?dzFMQ0QxWTFGNmt0N0N4L1ZvaTR3VFlseHJlejJOaGFGalVYMDh5V3NoUWdF?=
 =?utf-8?B?RVhXQnJDL2NrRzA0ck5icXBYNzd4d2VNRnIxQzdGRjdhOThOaTlJb0h6Y21P?=
 =?utf-8?B?YWx1R0FUa3RGSlUxekRuL28yU3plWjdoTUJDSnRFQlFRMWYxT3VxTkJJS1hk?=
 =?utf-8?B?WDhLOUUyTmN3RXl0a01Vclljcm0rS3NlcHZmeVFEbXVYbkxOd0c5MStOdU43?=
 =?utf-8?B?V0grbllNTmVqY1crQ2Q5ZWtJZlRERFBXQ0hsc3ZhNXZsdm0vMkpuWkpBUHI1?=
 =?utf-8?Q?DsyHNS1WAbYWWtmtsgvetlvYQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FA52198846ADA40B3D689BD67982DA2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5pGStllE+/S4OQV9ntX5d2h1gqwrK9qwcrXsvsPHna2a2gq6zWhvps64sw9dOZFH8ty8oFi7hXi+/Q4LFkqE04yzUEZTkJWHJN4eNRvdngINcyX4AlDXFEiA0FiCyAKZRrn2x1jRHRTk7Jw22x15mu5cyoWn4NaevWlVquSPwTNwlxHRlJh87rxB45D1R/0ZXsFqWdZpb8fIWIs6asxx/3bqPnM18OVc3Kxu+1PRtAo/ohF8OPeZlrPQd3kbSdpL3atsXS4nCSWtoddrmcpYD6OGTKHtzPQwMzy+kHefwwBbt8vXDjSjD1fra85Fqp4eU31y2bQi9+wXteL2uU07C3rhwbpoYO1KvpTT0BWg0HpDbdDb83SPxrBA+q4Uf4WMupXp8+j004V2inVlX7S2u1RE1NzzeSvWb+tAV9h/DmwVTJ8evrMSQB1esN6idmHyo1y053l4PhPxI01+++0HL82O1vPUdPoRP6gmoXBlYYT0MyK9+7jsFxc6a7fbb4b8LKQLLk1PWvlRWenIzwDPSjxKbs4PjW7PoE+ZAJPR+7N2Rym2gF0pUNwQys8Z9zFX+Y1mN8cZJjzxy5ps8SyDjRmob8YrZfCoxS6bSQhueFh/y85pchsyUPwOl0nuM6XT4swLewmfGFo+AFojroY9Y3gphoCsdYMwpQ59LwSMmwj6zFtBmP5gyKQfGGRG2hFeQfii4OyRhATQWM3QqFSYwFMtBJrK1U8uFaugPffJcasVlJSoEVtBCHqeVjfiS+CgnTtMR+Cm21wYUmZiesBLmnCrvU/sI/yYg5srGKG4ABHzBeelXcO9IwpaQ2g51er0DrGD37zzKGzfH2PYp2ZyIJfxbhyhBZ5WGmw7jcmZzvYZi1MbP10WrRQFtGd8UPm0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8731dba-162c-45a7-91da-08db37037b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 01:00:29.9455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJ5ijstBB4SBlRxRR72kkmEOGaaTCklOVC0Ma5aCYHvSIqYZoXSojVX82eKijL1Y4AupnjBoLIc3Hmazf9p/Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
X-Proofpoint-ORIG-GUID: KIWb0khXtLHadfQ5QCfVaWq8S5NVRZS9
X-Proofpoint-GUID: KIWb0khXtLHadfQ5QCfVaWq8S5NVRZS9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070007
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gV2hpbGUgdGhlcmUg
bGlrZWx5IGFyZSBubyBwbGF0Zm9ybXMgb3V0IHRoZXJlIHRoYXQgbWl4IGdlbmVyaWMgYW5kDQo+
IGxlZ2FjeSBQSFlzIHRoZSBkcml2ZXIgc2hvdWxkIHN0aWxsIGJlIGFibGUgdG8gaGFuZGxlIHRo
YXQsIGlmIG9ubHkgZm9yDQo+IGNvbnNpc3RlbmN5IHJlYXNvbnMuDQo+IA0KPiBBZGQgdGhlIG1p
c3NpbmcgY2FsbHMgdG8gc2h1dGRvd24gYW55IGxlZ2FjeSBQSFlzIGlmIGdlbmVyaWMgUEhZDQo+
IGluaXRpYWxpc2F0aW9uIGZhaWxzLg0KPiANCj4gTm90ZSB0aGF0IHdlIGNvbnRpbnVlIHRvIGhh
cHBpbHkgaWdub3JlIHBvdGVudGlhbCBlcnJvcnMgZnJvbSB0aGUgbGVnYWN5DQo+IFBIWSBjYWxs
YmFja3MuLi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFuIEhvdm9sZCA8am9oYW4rbGluYXJv
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAxOCArKysr
KysrKystLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCBkZTg0ZTA1N2QyOGIuLjE1NDA1ZjFmN2Fl
ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTEwMzEsMTUgKzEwMzEsMTQgQEAgc3RhdGljIGludCBk
d2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+ICAJdXNiX3BoeV9pbml0KGR3
Yy0+dXNiMl9waHkpOw0KPiAgCXVzYl9waHlfaW5pdChkd2MtPnVzYjNfcGh5KTsNCj4gKw0KPiAg
CXJldCA9IHBoeV9pbml0KGR3Yy0+dXNiMl9nZW5lcmljX3BoeSk7DQo+ICAJaWYgKHJldCA8IDAp
DQo+IC0JCWdvdG8gZXJyMGE7DQo+ICsJCWdvdG8gZXJyX3NodXRkb3duX3VzYjNfcGh5Ow0KPiAg
DQo+ICAJcmV0ID0gcGh5X2luaXQoZHdjLT51c2IzX2dlbmVyaWNfcGh5KTsNCj4gLQlpZiAocmV0
IDwgMCkgew0KPiAtCQlwaHlfZXhpdChkd2MtPnVzYjJfZ2VuZXJpY19waHkpOw0KPiAtCQlnb3Rv
IGVycjBhOw0KPiAtCX0NCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJZ290byBlcnJfZXhpdF91c2Iy
X3BoeTsNCj4gIA0KPiAgCXJldCA9IGR3YzNfY29yZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+ICAJaWYg
KHJldCkNCj4gQEAgLTEyMTUsMTEgKzEyMTQsMTIgQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5p
dChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXVzYl9waHlfc2V0X3N1c3BlbmQoZHdjLT51c2IzX3Bo
eSwgMSk7DQo+ICANCj4gIGVycjE6DQo+IC0JdXNiX3BoeV9zaHV0ZG93bihkd2MtPnVzYjJfcGh5
KTsNCj4gLQl1c2JfcGh5X3NodXRkb3duKGR3Yy0+dXNiM19waHkpOw0KPiAtCXBoeV9leGl0KGR3
Yy0+dXNiMl9nZW5lcmljX3BoeSk7DQo+ICAJcGh5X2V4aXQoZHdjLT51c2IzX2dlbmVyaWNfcGh5
KTsNCj4gLQ0KPiArZXJyX2V4aXRfdXNiMl9waHk6DQo+ICsJcGh5X2V4aXQoZHdjLT51c2IyX2dl
bmVyaWNfcGh5KTsNCj4gK2Vycl9zaHV0ZG93bl91c2IzX3BoeToNCj4gKwl1c2JfcGh5X3NodXRk
b3duKGR3Yy0+dXNiM19waHkpOw0KPiArCXVzYl9waHlfc2h1dGRvd24oZHdjLT51c2IyX3BoeSk7
DQo+ICBlcnIwYToNCj4gIAlkd2MzX3VscGlfZXhpdChkd2MpOw0KPiAgDQo+IC0tIA0KPiAyLjM5
LjINCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5j
b20+DQoNClRoYW5rcywNClRoaW5o
