Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9BF6DCF18
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjDKBRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjDKBRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:17:36 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEAA2D70;
        Mon, 10 Apr 2023 18:16:47 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJ5ijx023548;
        Mon, 10 Apr 2023 18:16:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=GdJ96wbUkyJKo3drG40W8LoFSvmHC6kQ8vQfpF3Bu9Q=;
 b=VwicvgowctXbEPoaor9yE46tLj4tklGr4txb2/ifzjZI1sELisHdjB1JSIoG1XrRAEmc
 FwR2itkYQ1SPWJjRO2MUhR+vhE4DEmJAqJi5gcrUuoREGj9OvU278vfKsjLqowq0+E23
 2qNT3+Vrb3dWXX89Hox4BTzlh/5LqDlcn8mhEzA8wRnWvnITqH5Q+m/d8U3hzAweuCT1
 RrsBNaZqVut7ColBkC8d9HAujlfXutO99G2PDJwNLUq8AMXZaPqMRTmdl3xcbr2Klik0
 rn6lG2Lbrc7vddV8V2/t3mutot1WKDTq5yNiRxqbjfhXtBX8b8sK+Hs4tfyIyZXqOETY Ew== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pu7h8tquq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 18:16:26 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3AD9A400D9;
        Tue, 11 Apr 2023 01:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1681175786; bh=GdJ96wbUkyJKo3drG40W8LoFSvmHC6kQ8vQfpF3Bu9Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fhYpVnd7pmZtSkAfCQQBIclKJCO12/+rsqsuTvVxm4ytub89ajYEDg0AC88UZAwf5
         2YdYxMhz7JQMAj0tcThZgeFdABtNuYckeMRnaGnX689Qb/Iy7KknTmubFRTf5wttp4
         UMsOOj7L5TC/coq6HhLORMGAjAXHQcOxwX7vtmMb+JQUuxXODdsnHZiAroNWpQlY3A
         UJHEUP9iW7jYHBXkdrimNz0aRwx5tujlRvoJG32lOEd1z/Gv3KASHlfvAjr9qsbZ5j
         ZigYprlmnvhCwSPzVZ8IuwzUANjyjsHbif2OmB/gYvSjRZiSbmBfpwB/xaaw/KHySr
         PgLUEqfR1dDug==
Received: from o365relayqa-in.synopsys.com (unknown [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relayqa-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B467DA0087;
        Tue, 11 Apr 2023 01:16:24 +0000 (UTC)
Authentication-Results: o365relayqa-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=keJC6Lov;
        dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relayqa-in.synopsys.com (Postfix) with ESMTPS id D281322792C;
        Tue, 11 Apr 2023 01:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhmPcCpp3QWgzJlDPFtiEOephk0jmcrZBbyIf8NXzGqX630SzjXDOy68HCHH74/vtuhk/8bRry4SlmcFSSS1UNo5GZEskO4mioKIHvluZY/+Q5e+TYNOzjXmz73DUUsrbFUeXgNCYqFSPaHl6jHzThvuIp37DalHgSOv7YZNWprip01KE87ucxVhSvZ+TmtXSkm/udrmTHEkIUJy/HIXOlQsuQW2qJO7e7ztlOmKziFHH8roPy6Cz9pRX1eXLpbg5mkMueJZOf992hxHsbKeMJMr/NPQGv1AOLGtsdI+H1YRG7U02UMd2j/Xe8bd9zOKOwuE0MAIrTmm+scQEWCDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdJ96wbUkyJKo3drG40W8LoFSvmHC6kQ8vQfpF3Bu9Q=;
 b=AhWs7w2rssXIxWYnei4Et9Eo4Usc5D9V0XM7DoZitNXfymM4wBHJU0u8po/4KfSAq9p41SK6KI18ev6M/m9MOtRopmcIEOOKiAufQ2NGzfoUIKeiAZZ5GSPmA2FqULXwUgj8/jjRj+T0U4BMFjmuPBbOTDNVzUcEllBAkRnur6pM1vSOAZFx+uMoVuqefRvQj4M/e02N+rKP/5FcUAJfxLgBTJqDlcE4QOGMji+DuphkFOJ4k1lFtWGuZQ1mqXYdGDPKl9av3C6TwAGvzm6HXrWNBmmlBfGmej0i0hRVD2GeQ2xywRxrrXnxo3H+5jeW4gKfHqMxFqR2QjrRVnn90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdJ96wbUkyJKo3drG40W8LoFSvmHC6kQ8vQfpF3Bu9Q=;
 b=keJC6LovIOsV0rCeJ69zr0Lrpse2dAaud+fG6b13DJxHT6YjOJisYluV9oDmnh5KfXtcU3/s2lemSym1PgPBq5l3VmDg2W0brMy31bo/XqYSAH5Y4jGMCnarh/1VgsiM3VZhEF13zCWmnSuHu5N09bccQ7g3ViZlvRF35gizffw=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 01:16:18 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::a6ef:a9e2:ad28:f5cf]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::a6ef:a9e2:ad28:f5cf%6]) with mapi id 15.20.6277.034; Tue, 11 Apr 2023
 01:16:18 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Rob Herring <robh@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] usb: Add explicit of.h of_platform.h include
Thread-Topic: [PATCH] usb: Add explicit of.h of_platform.h include
Thread-Index: AQHZbAPtY02Z0PxbX0itJAEJASbM568lTmSA
Date:   Tue, 11 Apr 2023 01:16:18 +0000
Message-ID: <20230411011615.33os3viihcdw4llp@synopsys.com>
References: <20230410232639.1561152-1-robh@kernel.org>
In-Reply-To: <20230410232639.1561152-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|SA0PR12MB7002:EE_
x-ms-office365-filtering-correlation-id: 59dcc576-350c-470e-a0cf-08db3a2a5a6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xsxnr5HrnSYciSin1RmRCZXYYCkbueNHxZcXjvJEYT8TKNtAAyXtp4aXYEWcNJPmHhyFQFCOVKxQVbZ522WDgOCli+0Nrj8N3RVOKcFIR4n47J7ubMoS+/x9mAWCX9owfqeAsN6RprGytJd6SGhFoDaeKEbwVxPzFEvG4gJrmECLVHT2pXnLQ7HaCd7ocm6sdcOrVJKMcwNEYO33cq9EVw9qWb+6i/6Qq4+6LVjgm63J4Bgx1i32aJ2LPgIA1cPgmsRyxBFNrhG+W+5xKo0CZk8oN/GMRQOnIgSo+Cr5Bzv6y9n8kQrCk12njY4ll6y0iHXp3HVtfVByOXTFJ5eRL+gGVguOIiZFt9yBp3jCQNU9cJTI/OCzF81W/+tfmIQLOsHK1tiShhlXRQPQHcNxwYT6hfE8tdwkTWYBTma05oXD+EHgVcoHY7V9LDwE4hXySqsVAt43/qhu8Hxew9lLnGP+6Eps46goxjAkscVUjt/ZB86HocuwvB3/QF+f9pqx1isTbzzBWhaRh6l+KAkSFobV+8lgnUtJrDWqaMQHmnNjq+VXx8DN5X3mEELiHr6qLB0ugzxl/YF4EIC24sKRDAGUQt0FMdQxsTcDiIJvzi4oxcogDYbzw8QhTy6kjzt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(38070700005)(2906002)(36756003)(8676002)(8936002)(38100700002)(122000001)(5660300002)(86362001)(478600001)(71200400001)(2616005)(6486002)(186003)(54906003)(316002)(26005)(1076003)(6512007)(6506007)(6916009)(4326008)(66476007)(66446008)(64756008)(66556008)(76116006)(66946007)(91956017)(83380400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmhxSk54ME84TkpCZXBaM3F3a0VxeGlIRjVFYS9mb0pCK1I2QVovL3NkQVRa?=
 =?utf-8?B?K3dSYjFYL05kc2I0RS9WS0Q0ZURVOUd3NTYrQjZGcGdicTVPZjRMM0tTNmkr?=
 =?utf-8?B?ZUVPTi9HM0RmUlBUbHVPY1Z6L21UUFVSV3c4VTNRRFZrczY2U2JyM2tsNXp6?=
 =?utf-8?B?SDlRYjJobElXTVpodDZEbTN3bkkwa2ZTZzY0OWl5c1ZQREZTcVdGenZYMVgx?=
 =?utf-8?B?QlJnKzIvRnIwaGFEVUJvOTFnUlpCdVBqYndjTGo5U0Z2dnJXUzgyVUd0T005?=
 =?utf-8?B?Z1BaQmcybFhtcnpycGNGOW9iSzY4VHQ3ZWdvaDdLT0VhSVpxUVlWK0QwR2w4?=
 =?utf-8?B?MG15TVF5dmw1QmNTdmtJZElsRFpaTXh6OFRxMHB5UDMrZ1BSS0VzaWRzM28x?=
 =?utf-8?B?OCtqZFUzZHFZMThUWkltODlIL2Jla3NaNHBSRlUrMEJLTndEcWNHQzZvUHFo?=
 =?utf-8?B?aHVyM1dJZk53UEZNZ3E3VDQ4dTY5ZWFBNkFDYjR5OE44ZkZJWGJUYVNZeGR4?=
 =?utf-8?B?bkZXbldyNFRYVythWG04bWNLUTJJNjBLNzE1cHFsZm1RbVI0NGd3czVKU2VH?=
 =?utf-8?B?anc2NDBEYWdSSVlCdkIrdFI5T0FtVkp5b0xTcW4rdldTcWdra0xYN1JlN2dO?=
 =?utf-8?B?M2U2TWtrc24rM0FQQWpveDB1T2pHMkdhU0JmZnV4ZGhyd1NubkQwdTV4dW1y?=
 =?utf-8?B?dU9QdFZGWk41UGttdm5WMTF3ZHRvNEpIYXlLbWJnaW1jamdsSVl4N0E5cURU?=
 =?utf-8?B?WWlXVE9WVGxQZVlYTVNuNlF5bDRCU0dyNnpvaGprT1pYV1pjUDZGUVQxRTc5?=
 =?utf-8?B?Zm1PN0RGOWdCYnJ4WXU2WkFWRFhBTUh0L3FsbTl3SDdUa25zR05PZmFadWl0?=
 =?utf-8?B?UmV5V1I2TFBzRWYzMWsrc05FV2JhQWk0QkhpaW5JQjhsdVRteUVza094eHJH?=
 =?utf-8?B?K1pURndNbTFlNnhQaUZTd3dZZ2Y5K2s1SWFER0hqY0kxZ2UvZkJ6OXZKam9u?=
 =?utf-8?B?ZDA0R050WnE0T2xxZDdBL0hUcmpVZ1BaT1RiUXlnT2NyR2RyRktxZTVEaFVz?=
 =?utf-8?B?d3VWKzlnQnV5WkFwakpkVjVPWTFJa3diSzgxT1lodzhsaWR1eHdNRjJ3blZl?=
 =?utf-8?B?ZlErUXZibUNRSC90blZMWlpSUkFhVGY3NzdrZDhhRjlEUENsZ1dyMnl2K3lp?=
 =?utf-8?B?K0NEZmpLK0NsSGZRd0hOeFdUWmszYng2bW96RkZlS2p3YnBLWHpVZk5Kb0w1?=
 =?utf-8?B?NWhzNEI5bFRkd01qeG5JMXhtbDVLWHFWVVU5ZlRYOGVId3J6VlBHd2I2YTkv?=
 =?utf-8?B?MTYvbmRjWW40QkJXSDY1bi8zWWJqMTZUcVdKVW5WQTl4eXByT3NmbzhxbE1k?=
 =?utf-8?B?ajV3R2NvM0pZTURiUnAvS0FVN1ZIelMvS3VaL2R6K3g5cGxYNWZodmpKdGNL?=
 =?utf-8?B?UmFxYlZhWTlOaU9LQ0FmVWl2ZnRVWDh4cFkxVjVwSUpadWRVSkZUaGRseTBx?=
 =?utf-8?B?WmZIMndMS3JUWmtoOUhTaTg1cjBUeUJpbzd4N3pwZzRhd2tKMmJ6YTVYY24r?=
 =?utf-8?B?RHRXVERBWWhLREtZZ3Y5UUlNNWxDV0NLci9EYzVKN3YxVDVSU2tRQXNGalRM?=
 =?utf-8?B?M2dLenhPSzBqd1dSQmkyTFBXeXNPcnB3Z0d4WGg4UHczQ2YrQlhucHFuMW0r?=
 =?utf-8?B?Y2pZVVAvT3ZKVDgvdHZWZnVZT0szaXFWZ2tOZ0xEOS84cWNObUpsdUVHSFdt?=
 =?utf-8?B?VExrOHFpU2Q4Z05kWThsaExFZlBKbjlwdElXQVlaVkdIY1p6d2lJSDBsZnMz?=
 =?utf-8?B?bVdIV3BXOUY4WXRpWnpQUm9iUWVjL0lPRmJIbmRwZDNtOElYQ0J5K1kwREFT?=
 =?utf-8?B?QmJkNVFmaHBCUjB3WWJIbjZ2TmROZEJKRDF5cFRxaGxmUTVMZlRRT3pWVS9y?=
 =?utf-8?B?SmRvRm43MXBtOXBKanNDK0ZiM0RLL3h4V3YzNTdZN0xhUDNWVXFydDE3S29s?=
 =?utf-8?B?U1NEOFhPTWpmRGxocERkMDV6Wk1TNlkxbVBUcVhVelJ0Ni9ScDBPS1BjL1Jk?=
 =?utf-8?B?R0lFNENaeVNlYUZFeVVBTUxyWUt4L2t6Y1FWR2w5V1JPMXdHa0dnSTM2c1Ri?=
 =?utf-8?Q?t3CcoEZuJOQDgMWqDQ6+Moawa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B38D7A246105F4BB2C9A6D01B884DF7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bEc2aXkrVXJjVm5iMkZHY2RmbVpjcWZxYm5yTjBPdVA5em1QTGNMTWxrMi9J?=
 =?utf-8?B?cTdKZFUrT2MzbEJXWFBONjBSVnYrM0VtVnZHYnI2cFFQTGFBVW1Ldy9wQW5V?=
 =?utf-8?B?Z0tsRW9ER1hTeXJXRTR6dkpBZS9DOGgrQmV1N0xrcTZTZURNRWZaQlQ3UDFX?=
 =?utf-8?B?dW9pVGZFWXpBaCttRVJINE9kbUVJVG5SOWtmbTdnOUtNNGJvanQyT01vbzg2?=
 =?utf-8?B?YWYvTEVnWjBqTXh2dzJNb2VaY1l4OVpRTStrc1BSVnVubGtFV2FYL3pzejNl?=
 =?utf-8?B?dGI5amdETjVucUhUcFhUR1dLRHVVWHhhYUJKS3A2UGtPdWJXMzg0b2hvZEQ1?=
 =?utf-8?B?YUZ3ZHJlMHFkUnYzU0l5UitkNWRyOU02Z0FCYWxDN2dxUTBRd1BxZ2dmNHZH?=
 =?utf-8?B?VDhmNVpSMDEyWmdab2xhQ0Fic2NMb3dpSkI0am1KdkQwZDk2clV5Mm5kT1dT?=
 =?utf-8?B?V1Z2emROd2NzT05rY3k2N2tDcW5aQmZ4TGJFUXRqWjNkeCtDR0pod2JvRDQz?=
 =?utf-8?B?Ty9TNkc3OFcvbkN1TWl4R29oVmxFQWp5Ujk2YVNVWC9nem5lUEFUV0hzTU0r?=
 =?utf-8?B?ck85V0d4cmVjYXhDMGxLVFpRWi92c2ZhYjdFeHJ0bkhFWWgwbGFkY3NSL2tp?=
 =?utf-8?B?UStVWStscXd2R1JUZEtjZHUrNVNkb3lBV2Z5UFVxL25oalVNdDFyQjRHS3ky?=
 =?utf-8?B?M2FydW1wYXhUcFAwWkVoZDhSL1BtQTF2TU14OXpreW04OGE0ZDFob2NVV2dv?=
 =?utf-8?B?YXRCT3duWUdzbWJPdStXT2E1NVBRS0dzSFZtcEUwNUl0N0hhOU4yeG8rc1hl?=
 =?utf-8?B?RTU2V2x4MmVuZ1B4dE1rZkxoWmx3elFMRWoydlhReDkvRjRvbkZna0ZOc1dJ?=
 =?utf-8?B?ZHZQMUhzMVpuUjBvNnpWWXBCV3RaUGFZTDYrSnBZRlk0bC9IWCtwSlpiS3hQ?=
 =?utf-8?B?ekQvcWF5WUJYVlcxekVCUHpyWm1paTlqRkN6Y2hvdVNJbWFiTUR5Mmx0R0hC?=
 =?utf-8?B?TUdKNmVFdENvQnhBWFIya1haZlZxd1NVL0ZDUFJhYXlmQ2NFd2FEektQNkQ0?=
 =?utf-8?B?QW5CNUk3eHY3d2szQVlCTVZhWElHSFdJTUFGeGs1R2xLNlloZHJsUUlsNjc4?=
 =?utf-8?B?Q2tka1o4VTF1blJiVldqNTVYRjZxRnRTQlhaQXpDVjFjUHVsWEJPcGFVQXF2?=
 =?utf-8?B?S042TkRnMEpmQm1GWlBjTmJ6UHFLODNuUmhMcUEvWUZUSWN2RFdEKzJyTDMy?=
 =?utf-8?B?Y0h5dXJFektaU3h6djdFaUJZNC9rVDlYTWRoekRZTm4zV0xBRXRaRmRtNzJk?=
 =?utf-8?Q?vlYSR217kE9oo=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dcc576-350c-470e-a0cf-08db3a2a5a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 01:16:18.2889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vsV3st6F3wIAUJC7ABDHXML5onqgV5oc2qNcXDDsCgD2BXF3RqEYP3ADiiKicmzKz41k6hetzTkV8DlatdPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
X-Proofpoint-GUID: QO9sCqzIrb5B3saySGftWnjVK4wn9PdJ
X-Proofpoint-ORIG-GUID: QO9sCqzIrb5B3saySGftWnjVK4wn9PdJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_18,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=627 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1011 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304110009
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBcHIgMTAsIDIwMjMsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBTZXZlcmFsIFVTQiBk
cml2ZXJzIHVzZSBvZl9wbGF0Zm9ybV8qIGZ1bmN0aW9ucyB3aGljaCBhcmUgZGVjbGFyZWQgaW4N
Cj4gb2ZfcGxhdGZvcm0uaC4gb2ZfcGxhdGZvcm0uaCBnZXRzIGltcGxpY2l0bHkgaW5jbHVkZWQg
Ynkgb2ZfZGV2aWNlLmgsDQo+IGJ1dCB0aGF0IGlzIGdvaW5nIHRvIGJlIHJlbW92ZWQgc29vbi4g
Tm90aGluZyBlbHNlIGRlcGVuZHMgb24gb2ZfZGV2aWNlLmgNCj4gc28gaXQgY2FuIGJlIGRyb3Bw
ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0K
PiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMgICAgICAgICAgIHwgMiArLQ0K
PiAgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9yenYybV91c2IzZHJkLmMgfCAyICstDQo+ICBkcml2
ZXJzL3VzYi9tdHUzL210dTNfaG9zdC5jICAgICAgICAgICB8IDIgKy0NCj4gIDMgZmlsZXMgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtYW02
Mi5jDQo+IGluZGV4IDE3M2NmMzU3OWM1NS4uNGQ2NzRhMjQzNzg0IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2R3YzMtYW02Mi5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdj
My1hbTYyLmMNCj4gQEAgLTExLDcgKzExLDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9y
bV9kZXZpY2UuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvb2YuaD4NCj4gLSNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gKyNpbmNs
dWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9yZWdtYXAu
aD4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvcnp2Mm1fdXNiM2RyZC5j
IGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9yenYybV91c2IzZHJkLmMNCj4gaW5kZXggM2M4YmJm
ODQzMDM4Li44YWFmZDFkZGYxMjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91
ZGMvcnp2Mm1fdXNiM2RyZC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvcnp2Mm1f
dXNiM2RyZC5jDQo+IEBAIC02LDcgKzYsNyBAQA0KPiAgICovDQo+ICANCj4gICNpbmNsdWRlIDxs
aW51eC9pby5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiArI2luY2x1ZGUg
PGxpbnV4L29mX3BsYXRmb3JtLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNl
Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L3Jlc2V0Lmg+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9tdHUzL210dTNfaG9zdC5jIGIv
ZHJpdmVycy91c2IvbXR1My9tdHUzX2hvc3QuYw0KPiBpbmRleCBmMzkwMzM2N2E2YTAuLjE3N2Qy
Y2FmODg3YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvbXR1My9tdHUzX2hvc3QuYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9tdHUzL210dTNfaG9zdC5jDQo+IEBAIC0xMSw3ICsxMSw3IEBADQo+
ICAjaW5jbHVkZSA8bGludXgvaXJxLmg+DQo+ICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvbWZkL3N5c2Nvbi5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L29mX2Rl
dmljZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQo+ICAjaW5jbHVkZSA8
bGludXgvcmVnbWFwLmg+DQo+ICANCj4gICNpbmNsdWRlICJtdHUzLmgiDQo+IC0tIA0KPiAyLjM5
LjINCj4gDQoNCkZvciBkd2MzIGNoYW5nZToNCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhp
bmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=
