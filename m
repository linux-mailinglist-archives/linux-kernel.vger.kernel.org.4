Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDADD6BA4AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCOBaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCOBaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:30:00 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59CD19F10;
        Tue, 14 Mar 2023 18:29:24 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ENjQDC028857;
        Tue, 14 Mar 2023 18:29:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=ryGnJm7nBggTaby8NfpG60TYpgqFC9yE5w/l75mk00c=;
 b=md0tIFJ+47aWUhD4flFYsUb0edY7AM/3OGqOwKvzBHRvxTtKLvn3WeNfSGSFL8IVipyo
 GX+9EMz/IhR9V3l/HB6uPaZIiB9BInri2QijKT9qxlxB/9/IH3Wxh1q/L/xu8rUvICCM
 SAQvC6BzP3AnU20X6YeeYsnJYuHEIy0btb37xoBPLVtZLJNxJE1F79wc94pmFMgCy0l1
 x5grovjywPWSM4WHuChUl7Ul3WqhFv4r5dc9YeHmZB0VR8xd0i0TGa8PUEf32aaktxct
 xtFR+AzNgcM3tytX8WOjadSACmRH5vQn8DQSGZ7JnOvN4KwtlBDEBsRwHaNoiJiNv4Sc 3g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3pb2vm8a6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:29:11 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CBB2040099;
        Wed, 15 Mar 2023 01:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678843750; bh=ryGnJm7nBggTaby8NfpG60TYpgqFC9yE5w/l75mk00c=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GH/DxQQkOvW9voP57Ag/Fikdh2CgkmXo1I6jC6OkfdXNoVa6IfAUmwlZ/8EKhOSZq
         ix7jmAED9BhDWzfJx0zJuXxbt2C6PxdLhdcQf18I7Lw+BbPkS38WL6Lw+vmDG7Bhe5
         APg8EZEMhUOTDL7cicWZfBD6FlmWXdNbLBBabzbsdqqwj8B7ZWyNQTFMPRBi8jgGvN
         C3WqIrDAt3eOo87a+3znrBDJDYviq5pcIjhWdcAQ44Efzg9qhe3Sh/y3VcGeD+YVZ1
         s6Q9cdI4RjIO4ZPweItRpT8z0ya85DuT84ogcihl3SIraytfqTOusjIu0qbkiruW5B
         T9y3ZaqbBiiIA==
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 712E3A005C;
        Wed, 15 Mar 2023 01:29:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=fI7BbBIF;
        dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8212A2286A6;
        Wed, 15 Mar 2023 01:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsIDp+IvYhag90fMvrBrRgbnms8qnX2VPnGLoMMt47DDOqDFogz6soXtdMtnJIl6RSGIeiAxBHvEpM5ZrJW8l03OVkICToF6GvaKwGGwMFckQarLIGduPj5qfOmUZJo6Q4FgXsRIhnprN8T/wmYuRtl+keMIumhbHamgXPkk1rBf8eE0chPT6kDqaA/pZwmO9ceQYg2WM+28hF+5kEtSQai8/hjEVAvK2/vj7A9BdcDOzpVutsHfi2g8xnLhotJUCFhBZJFF9eIpHkyqY7oAvyF4CBOSEZjkVOl52NqbDgGyzd4OFmudClijBN+mpm3H0kjVSettwTod+oSPpYSJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryGnJm7nBggTaby8NfpG60TYpgqFC9yE5w/l75mk00c=;
 b=jHObwVMphsCPoMo3kscM2LL4hky2IlIgKCTgyRFoYLKfOzRbiJuVVLXki8VYm8fFeNG8ACM2D3CJXxDJneG32SB6D8ti0SWO7CRCzKfL0Qmq/6/TeHjxbbsoscAlPVrwB4E1u4vA6NGVL0T1fppxcGyeyGDu55pkplgWXnuTkR4MLGnS7SOHKJpARPzhHsMmLXFcjMLvmU3S6xqO8ijmHROhc9KWRb9lLUwHttSnV+9YAU3JyX021rNOtH8ubzs0V9anAZrJ2riCz7qHB2zNamiwSpugEqKjX9UDcQPU5YNSatwiGwUmAYX+5jkqSnaUx7yWp0TbseVdbaLDQy9kdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryGnJm7nBggTaby8NfpG60TYpgqFC9yE5w/l75mk00c=;
 b=fI7BbBIFddnQeFcHIjNTCS8Uf2cJh61X+rD7ecq+mx6Q0QD1Tf7HZK/bGXlW+tBKVJI7iVBTGH0q7Ktn/NMmBigKRfN9O2avzCAr/xqu2InSmfI1hwHVf8p/J1p+kB+g0Ah7f84PNN0ZmJsrvlaBehBLs5lnSe4WxLlfB9gbIWg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 01:29:06 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 01:29:06 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v9 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v9 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Index: AQHZVtaqgjzcxbPOUEmQwYfa9MH4hq77DViA
Date:   Wed, 15 Mar 2023 01:29:05 +0000
Message-ID: <20230315012857.rzfrad3n2pbmjvwb@synopsys.com>
References: <1678840783-15472-1-git-send-email-quic_eserrao@quicinc.com>
 <1678840783-15472-6-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1678840783-15472-6-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CYYPR12MB8653:EE_
x-ms-office365-filtering-correlation-id: fd95f158-d163-442d-32c9-08db24f4aac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IC29xPxTFyz8ZAHTGhiGK+jBVn0WRzH5UFnjboyYJy7gGAnigW+NdxpSyRjZaaogFgdHhLWOCZj2GkKlQEEvfki7wNkVI9lJnCfKdhk85LOKFqXIrTC1Bn6LYxPPMWg/pZvQCljc8XaFk7WDJYz2TZMd1PvpHIPp596y7NG5VHCxTyPK7gE9DBAr38TIqsCh5mLzUmjj6+RdiJg1VhLj0GMUsZsOLhS7zhgONQDoYOCjKa1D8bHw9RaElweXvc0AxkOOc2KuIBDmpN0ZcQG7yCh6iEi9QsK69F2g7Sk33Uh+FJvrndDYhxPYOgN/8zUoHxBNCENMOSs8+Kq+u9LZg7J/tXe2hRWN0M8R4PaeHIEiBXrDH2FaYtO1M5ERFQh1DiIcc3LbIvKIVwIkqLzhC/DZfTveQUQcA7PN6OwugzTDi6HwRgCEzAeIUwMa4ol08lJrLv+d1MVG32WJT+zoq8/AgSRIYffAqL28bySPJRnFLH/hfiWdURntrs4j77fGVdaB2T+5zSHtNhEyCvGddZfUu3yW9k1frLQJHd1q6JONfZExpb4MX0j0Mo5p+wyLwxBcpZ6MupSZJDqArHzLoa/kaAHfTd1sipPz2Nb/PKLJZ3Awq6+HxfcRiCbTNbiLtuh+36sxhADJoA7EgTz8Q+aKiLvJXZK/E1OBSas16lZKYyANt+9+NzH12Fd/n0zSiCzPWEqP8xMY2xZHqbOguQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(5660300002)(36756003)(83380400001)(66476007)(478600001)(2616005)(6512007)(1076003)(6486002)(6506007)(26005)(71200400001)(76116006)(4326008)(38070700005)(66946007)(6916009)(41300700001)(64756008)(8936002)(66556008)(8676002)(186003)(86362001)(38100700002)(316002)(66446008)(54906003)(122000001)(2906002)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUluVHRmRnBLLzBCWDN4UTIrQ3ZPRUoxWFVnWXB4SFdlcnZndEpmZkNYNURp?=
 =?utf-8?B?SXlqYWpTaEFsNnBRVnp2MEJINmZ5V2p0a1RFaUNLajNBWmNRL3BFamF4Ylhr?=
 =?utf-8?B?V1FEcjMyU3M4V2dBeDZIbjZRWGNiak11OGpOTHdNZWh0dnljZXBrQ1B3c0hY?=
 =?utf-8?B?SVlZR1ZReWhKcDB4SVl0c3ZycWM3Mi90aW00ZW9zSUtxVHJqdldYemhDMGt2?=
 =?utf-8?B?VGpOWUhPTklRVXVMVytNY1V3TkNMMmdOdGhrRUxSSUlmbHdIUndBVkx4T1Az?=
 =?utf-8?B?V0IyOGVSL21MUVExTVpPZlgzbFNzcTRLK05oN3VZVEs2OXlpVS9XTDBZS2p0?=
 =?utf-8?B?ckQ5SC9qcnhzek1yamRJaEd6UzRaS2xjZVNvVWUwRGFNVnQyYXZNU21sSVMz?=
 =?utf-8?B?UUttb1RhUmVTWGpudFN0UjZsQXoxZmlIODltRFFNaGYzNkdyZ0Izd2hrdjBo?=
 =?utf-8?B?UmdyTy95ZmdBdTdYUFpWSFNzR1lpeHB2Y0pZUEpmaXpnekV3UkRoNUkrM2lp?=
 =?utf-8?B?YXJuQjlscUZCQkwwNU4wODFaSTErVksra1RkSHJMOFlKUkVVeUZwY1dac1dC?=
 =?utf-8?B?VEZXN2NFOHBpMXdLK2EvcWFaUHJtMys2UUdxL3Vwc3djbkRvaXJRT3h4Qmo2?=
 =?utf-8?B?U1ZlNjJEc2xWNVgwUjZybkZtdUtVV2t6cVI5K1hqd1RrWEdaYU1aT3NCUk9x?=
 =?utf-8?B?Q0ZkcVRWQkYwYzNnUTFTOXhDOXo0dk9xK1JVN29VVjROYVNCaFJrRjBzbDF4?=
 =?utf-8?B?dnF5d2dyaWMxY1NUQ29QTDBIV1BUR3dLOXo5K09vR1ZpZU9vL2lnZ1l2Z3NC?=
 =?utf-8?B?NEJyVEVWbDl3WkJZZjR5WHMvelAwcmxxQmFzNURrZ2p5cGFvTDg0MlN3Y2dr?=
 =?utf-8?B?bUM1WEQzdU1PTUxwOHl0OEVCQm16aU14RkNObE5BTVB2YjlTL2ZGV1AyN21H?=
 =?utf-8?B?TmcvaS9DTHJFNS9KTEVyS3Ezd1M4R3NPalRRM3JWWUdzVG5FUGZ5dG0rNmJE?=
 =?utf-8?B?T0MzRjV0YWpPVExtamVlRWhlM0hZOEdrYXRicVg5R3A1dXlqRjNnTjBFcU1B?=
 =?utf-8?B?VGRKQ0ZmRDJTQjJZSnA3cytBeHFRdlUvMHgrNE5ZUWNvb0xjT1dpM0JTT2Ur?=
 =?utf-8?B?cDlRQ1Jib3c2MDlGMzRjTVRoOWlTcHVaWG1vL21uMzdlZHAvVHNJa3JGcUt1?=
 =?utf-8?B?SnVnc1hPNDVicURlK1pKU1VESGdGZUdaNGl1WnNVUzV2ZTlpK1Byc0Vib1BH?=
 =?utf-8?B?RXZzWVJSc3FIU3hCQmtxM0RYNnBVTERNdWF0cG1vdU1ENnE2bmhsMHp4Zi9D?=
 =?utf-8?B?dm1ldmpuQTNPVzRySEh1SnlZNXB2Wm5hUitnNkY1VEpEaGsvQTZiMEZtTW1V?=
 =?utf-8?B?SDkyN2xjWHl4T0VFNnNEVUhqYU8zOXhmWE11Yk1DeHN3UEFabFNGRE1kcUYy?=
 =?utf-8?B?WUhMdFM3cFhWN3pKVjk4VkdwL0IxTzJBeHBLQTFSaGxiZjd2RXN3Z0JFaGhv?=
 =?utf-8?B?UndjelV3dHdMclhqLzBJL3VnSWhQajNBdDFHQnh0T2pOajRzT3Z3Q1ZHMTR0?=
 =?utf-8?B?RG9obVR2S1ZrdWt4cGhjZ1lWUC9RckR0cnlMazREOEtza21Yb2REZ3pFL2Qw?=
 =?utf-8?B?ZmE3V2Znb0phTXFMWnE4bHNXV0JHOUd0Tkw5MkIwblJEN2hZUEZMcldIOUR6?=
 =?utf-8?B?cGtPaXh3akI5cHFaSmFNV2U3VDNlWjBhU2p3ZWw1cDEvUGRPblZwd0dBUE5P?=
 =?utf-8?B?OG5UclJmM0xxeWMwMmJyUWwzNEZQbWpmZHpFeTUvYXZtRnRXNmdkRml1eVUw?=
 =?utf-8?B?VDV5Nm5GcFBTSTRxTVdHdzhWQnBJMzk1YUhsUDlYKzhhVDhWZmFUTlg1TVZt?=
 =?utf-8?B?VVFqc2I3dnFCa0FLdmppQkFYYVJyVXhMMVVpWFIvTTg0VE53ZXFDbzBZMXo0?=
 =?utf-8?B?d1U2TUxjc3kwd2kxamNpUU9SNExaZjJiL1Q3a3VOaGhhelp0ak1CWEIwNnlY?=
 =?utf-8?B?ZXhlWWFkRXYwa0RvLzVqUDR2TXlJbE9rNDlIVTg2Z0hPZkhRTTIxTVNFbkZt?=
 =?utf-8?B?NDJHbUF2dFh6MDlLT3FESW4xc09UVnFUSXE2SWJpUmo5b29uRUcySmFZejRj?=
 =?utf-8?B?YzZSOVllOUJrc212OFBVYUVsMW4xTXRySnhpNEphWEY0czBkREJ6eTdobHF6?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B1E4388E11A0945BD05109E4C211F46@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ozU/nluCvhOowqCKIHr8/4agF3qw2zr5cTqZnubm/l4eCdIUYy2RmPijujO70C9Gwk8GHFohyLi5HKPeX1Rb0s80wdRA8COcAf18OLVF/i9OExKtJybh1+afXiNwLSDiqqtqW311I7vzYcZ7QOzePT6ibQ+uX/8CrNFtZkQD1f122DXXMAnViaLlClC2ZIVdZHYYeUGb6WUCgLkNYJHVIGGjyt240Xn0a4goygd7haBU8mDeoufQawxEgZEi9v0mSZmwiLg6Kn/DnuClcjq2fKjnHVlSshjyXTTwu2tAQ8zoQxZqIbt9kVZ/VCUsBmGpykNoprrQfZ8xmL+PC/IbJhMI3jt9YdhOWfNaTCPBEZBEWM0NT8Os+GfyeckRsyI3+Tv2Bb98hx8RXUMngGf1HOCKfPnkeSyzGfR2FqiDsgQFJMMvx9J0NTAO4VaKJilX0Ri7dWBdqEt/YXm0yo0ug7JlafILeY7MIuZ4YQwax5+zTacejzV3G0ke1Ij5V+jTEujsDQCSmMZGIXjW58t7IaRQdgKNxUE+/9cMX7VIT8nWI/P5on98MPgBcVDyc1UyuCkNQKs+ZMHMu/crC2F/L66LK8PmqPkK8+1EUWgCCmF4+1fWyulcf3cM49l9tBYLXIF5S2DmLceAu/pAkLsqE4U7/FxxAsm+Y/iI2vKA53J8clatNaBkHfogtxi+rrnjFaK8xFmZHiWshDF48vXWfGjZxJ/SX77aIrSmvEqRsMfTey6RYjSrF7MWV9qnsB47qz1pDZUqWbhPueH3bLI+mvBmspdflHM2MpdJZuxndXSGXB0u6leM4cigJn0nXc1GOcsuFhf+kff/5CjMHlpk1p/2yeFN4w9SDz3Aq73izkLSQ3umFLhxtNq5yizLTrXdiXZ9AObj6++yCTolIzKR6XacMgQfKt+qP/s2NFMj2lo=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd95f158-d163-442d-32c9-08db24f4aac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 01:29:05.8309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNSiVd3h3A/NffHInReGiMYdOxN7XzG2NZblTmSlLastx/gsSEzB0CVT+65qzOaUgTYnM3gvacJRNHk9x8txEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653
X-Proofpoint-GUID: uHKjU1FRUOVaasRGdDzKsFadCTobvZHA
X-Proofpoint-ORIG-GUID: uHKjU1FRUOVaasRGdDzKsFadCTobvZHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_16,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2302240000 definitions=main-2303150011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXIgMTQsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFdoZW4gaG9z
dCBzZW5kcyBhIHN1c3BlbmQgbm90aWZpY2F0aW9uIHRvIHRoZSBkZXZpY2UsIGhhbmRsZQ0KPiB0
aGUgc3VzcGVuZCBjYWxsYmFja3MgaW4gdGhlIGZ1bmN0aW9uIGRyaXZlci4gRW5oYW5jZWQgc3Vw
ZXINCj4gc3BlZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBmdW5jdGlvbiBzdXNwZW5kIGZlYXR1cmUg
dG8gcHV0IHRoZQ0KPiBmdW5jdGlvbiBpbiBzdXNwZW5kIHN0YXRlLiBIYW5kbGUgZnVuY3Rpb24g
c3VzcGVuZCBjYWxsYmFjay4NCj4gDQo+IERlcGVuZGluZyBvbiB0aGUgcmVtb3RlIHdha2V1cCBj
YXBhYmlsaXR5IHRoZSBkZXZpY2UgY2FuIGVpdGhlcg0KPiB0cmlnZ2VyIGEgcmVtb3RlIHdha2V1
cCBvciB3YWl0IGZvciB0aGUgaG9zdCBpbml0aWF0ZWQgcmVzdW1lIHRvDQo+IHN0YXJ0IGRhdGEg
dHJhbnNmZXIgYWdhaW4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbHNvbiBSb3kgU2VycmFvIDxx
dWljX2VzZXJyYW9AcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL2ZfZWNtLmMgICB8IDc2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhlci5jIHwgNjMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0
aGVyLmggfCAgNCArKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNDMgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jIGIvZHJp
dmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMNCj4gaW5kZXggYTdhYjMwZS4uYTgyMmUx
NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMNCj4g
KysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMNCj4gQEAgLTYzMyw2ICs2
MzMsOCBAQCBzdGF0aWMgdm9pZCBlY21fZGlzYWJsZShzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmKQ0K
PiAgDQo+ICAJdXNiX2VwX2Rpc2FibGUoZWNtLT5ub3RpZnkpOw0KPiAgCWVjbS0+bm90aWZ5LT5k
ZXNjID0gTlVMTDsNCj4gKwlmLT5mdW5jX3N1c3BlbmRlZCA9IGZhbHNlOw0KPiArCWYtPmZ1bmNf
d2FrZXVwX2FybWVkID0gZmFsc2U7DQo+ICB9DQo+ICANCj4gIC8qLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSov
DQo+IEBAIC04ODUsNiArODg3LDc2IEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX2Z1bmN0aW9uX2luc3Rh
bmNlICplY21fYWxsb2NfaW5zdCh2b2lkKQ0KPiAgCXJldHVybiAmb3B0cy0+ZnVuY19pbnN0Ow0K
PiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBlY21fc3VzcGVuZChzdHJ1Y3QgdXNiX2Z1bmN0aW9u
ICpmKQ0KPiArew0KPiArCXN0cnVjdCBmX2VjbSAqZWNtID0gZnVuY190b19lY20oZik7DQo+ICsJ
c3RydWN0IHVzYl9jb21wb3NpdGVfZGV2ICpjZGV2ID0gZWNtLT5wb3J0LmZ1bmMuY29uZmlnLT5j
ZGV2Ow0KPiArDQo+ICsJaWYgKGYtPmZ1bmNfc3VzcGVuZGVkKSB7DQo+ICsJCURCRyhjZGV2LCAi
RnVuY3Rpb24gYWxyZWFkeSBzdXNwZW5kZWRcbiIpOw0KPiArCQlyZXR1cm47DQo+ICsJfQ0KPiAr
DQo+ICsJREJHKGNkZXYsICJFQ00gU3VzcGVuZFxuIik7DQo+ICsNCj4gKwlnZXRoZXJfc3VzcGVu
ZCgmZWNtLT5wb3J0KTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgZWNtX3Jlc3VtZShzdHJ1
Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiArew0KPiArCXN0cnVjdCBmX2VjbSAqZWNtID0gZnVuY190
b19lY20oZik7DQo+ICsJc3RydWN0IHVzYl9jb21wb3NpdGVfZGV2ICpjZGV2ID0gZWNtLT5wb3J0
LmZ1bmMuY29uZmlnLT5jZGV2Ow0KPiArDQo+ICsJLyoNCj4gKwkgKiBJZiB0aGUgZnVuY3Rpb24g
aXMgaW4gVVNCMyBGdW5jdGlvbiBTdXNwZW5kIHN0YXRlLCByZXN1bWUgaXMNCj4gKwkgKiBjYW5j
ZWxlZC4gSW4gdGhpcyBjYXNlIHJlc3VtZSBpcyBkb25lIGJ5IGEgRnVuY3Rpb24gUmVzdW1lIHJl
cXVlc3QuDQo+ICsJICovDQo+ICsJaWYgKGYtPmZ1bmNfc3VzcGVuZGVkKQ0KPiArCQlyZXR1cm47
DQo+ICsNCj4gKwlEQkcoY2RldiwgIkVDTSBSZXN1bWVcbiIpOw0KPiArDQo+ICsJZ2V0aGVyX3Jl
c3VtZSgmZWNtLT5wb3J0KTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBlY21fZ2V0X3N0YXR1
cyhzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiArew0KPiArCXN0cnVjdCB1c2JfY29uZmlndXJh
dGlvbiAqYyA9IGYtPmNvbmZpZzsNCj4gKw0KPiArCWlmIChVU0JfQ09ORklHX0FUVF9XQUtFVVAg
JiBjLT5ibUF0dHJpYnV0ZXMpIHsNCj4gKwkJcmV0dXJuIChmLT5mdW5jX3dha2V1cF9hcm1lZCA/
IFVTQl9JTlRSRl9TVEFUX0ZVTkNfUlcgOiAwKSB8DQo+ICsJCQlVU0JfSU5UUkZfU1RBVF9GVU5D
X1JXX0NBUDsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gVVNCX0lOVFJGX1NUQVRfRlVOQ19SV19D
QVA7DQoNClRoZSBmdW5jdGlvbiBzaG91bGRuJ3QgYmUgcmVtb3RlIHdha2UgY2FwYWJsZSBpZiB0
aGUgY29uZmlndXJhdGlvbg0KZG9lc24ndCBzdXBwb3J0IHJlbW90ZSB3YWtlLg0KDQo+ICt9DQo+
ICsNCj4gK3N0YXRpYyBpbnQgZWNtX2Z1bmNfc3VzcGVuZChzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpm
LCB1OCBvcHRpb25zKQ0KPiArew0KPiArCXN0cnVjdCB1c2JfY29uZmlndXJhdGlvbiAqYyA9IGYt
PmNvbmZpZzsNCj4gKw0KPiArCURCRyhjLT5jZGV2LCAiZnVuYyBzdXNwICV1IGNtZFxuIiwgb3B0
aW9ucyk7DQo+ICsNCj4gKwlpZiAoVVNCX0NPTkZJR19BVFRfV0FLRVVQICYgYy0+Ym1BdHRyaWJ1
dGVzKSB7DQo+ICsJCWYtPmZ1bmNfd2FrZXVwX2FybWVkID0gISEob3B0aW9ucyAmDQo+ICsJCQkJ
CSAoVVNCX0lOVFJGX0ZVTkNfU1VTUEVORF9SVyA+PiA4KSk7DQo+ICsJfQ0KDQpDYW4gd2UgcmV0
dXJuIG5lZ2F0aXZlIGVycm9yIGlmIHdlIGRvbid0IHN1cHBvcnQgdGhlIHJlcXVlc3QgYXMNCnN1
Z2dlc3RlZD8NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPiArDQo+ICsJaWYgKG9wdGlvbnMgJiAoVVNC
X0lOVFJGX0ZVTkNfU1VTUEVORF9MUCA+PiA4KSkgew0KPiArCQlpZiAoIWYtPmZ1bmNfc3VzcGVu
ZGVkKSB7DQo+ICsJCQllY21fc3VzcGVuZChmKTsNCj4gKwkJCWYtPmZ1bmNfc3VzcGVuZGVkID0g
dHJ1ZTsNCj4gKwkJfQ0KPiArCX0gZWxzZSB7DQo+ICsJCWlmIChmLT5mdW5jX3N1c3BlbmRlZCkg
ew0KPiArCQkJZi0+ZnVuY19zdXNwZW5kZWQgPSBmYWxzZTsNCj4gKwkJCWVjbV9yZXN1bWUoZik7
DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw==
