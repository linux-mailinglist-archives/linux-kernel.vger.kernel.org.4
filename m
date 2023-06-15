Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16797322CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbjFOWbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFOWbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:31:34 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6281FD4;
        Thu, 15 Jun 2023 15:31:33 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FMD4Dh030963;
        Thu, 15 Jun 2023 15:31:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=wm2YWo7D9rU0+nRLWSVoq1VTT7ZnKgXtTeas0QTYg4Q=;
 b=GlNLMLFdEVZ8sOuxPYFa6yiqSuNZaaCwrityqtAr0Ls9iVAjFnwrfLQtSpx9FFUnk5jX
 fS5EBRC+MTsy1Euf5Nhapea2luLkoql/x7NkBU7ZW3XL8+QwLjKb4e/4LDWq2Qd/8Mc6
 tIdShkgGZHLNbOO6FyZoiU33qnW/4d3yDgS1JlBQTWBoXnpIHUDgjhoNtDMxSead2T0s
 z2p2qKyG0dIOKbPj1MGb4DExTONawx+iamdXEaEmLbMhGGKcW0tzG2z0SElI8LSwJDR9
 6e06l+1iAOvyESSFPDiyagS7J00eY/DZYZwDx6FjtbdsYhu1aEssZcblIqR9zwk/BnQg 5Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3r4qteuem9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:31:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1686868289; bh=wm2YWo7D9rU0+nRLWSVoq1VTT7ZnKgXtTeas0QTYg4Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dR8wEhpYL/tvvHtchNnw9FJgDL4QAtnXzjes56Zx58ELo+ocZQBSGizEIjsYtN6gg
         TC2MQVCZckxSRlxjySVOs03bgVO9xo3jP7SRLoi6sZbFVIrpk9MU0iOShU4WhJpAuy
         6iPWHcXpTMge3UOJGNPQH9AUXVcED9stOZiC7y7K0fNnGBZhcEtLGVQBIDuAclmi84
         7CZO4DLpeS9T5KNU0HVZMdUaoKjhJ8dPCA508dSIwQdS20wG9+0GqreayBs2En0cPb
         f7alqcdwg+czSiBE+yaYewq2LB0Gb2u7bkTmA/Az2MU9sRjVHGN4GYa3o9HqNurx2j
         VzwSFl8sP+6Vg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 01656404AC;
        Thu, 15 Jun 2023 22:31:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D0644A009D;
        Thu, 15 Jun 2023 22:31:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=MiKWNcU+;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7F18D40078;
        Thu, 15 Jun 2023 22:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhO/wu+plq0QNyARjbkMVUJorHm558td2OUmUMyLwMAYC8+YWO2ayk225G123yT4oghzEumcpTO34QlrjYwJyS/RkJKlkahbIw2yNM3DuSJB4nm3c8SnN51AmYSMLGvMXUQU/JxUpMU2lmMMiTHq2wrD/+J4T6AWSOIQYp4hxCyxLIAdLAbGCuw186XVF0m4s+qXEGXYNJR7fQkAZBqfwV1o9NToUJRg0MMYMSjDS6codydpWzpSiZjkEwkXmWDFmlDcs9eRBQDN+Oa+NjmW9TGQx4dRarslYpRwWNFEH+czRN/a8HKXRFyWyAW7dKq0uPEEyqFcFj7Z0oDPTvYIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm2YWo7D9rU0+nRLWSVoq1VTT7ZnKgXtTeas0QTYg4Q=;
 b=QLIDM19OI9TM/2tj/9MWwnZu824GJbZpkRbBkyNpzcdSb9Wah6lO9nnIZRoNTRNdfgs9p6ivrazqfIjU2kFWzy6ug0kE1+V3xZ5wghBa6b4KVZStVaJTdETeZi3zupPPAXF6aI/1tFEoMswUGm3tY3gxjF/Bgc7PF5MPK2C9Ui17W4LEy9sx4gK+Y3VnHN1ZL+hs/Xokh7H149vQ4xfFanZHJ1EKB/ZfCkLFvgqTCZcuZQNMe9wzpfSuuIVLTXBYmFrKgYIOWdnjOU0qS5ZTvHBDlP8elw99pmxx696/Y9oZx2NP1lJEgxpO+IvPQdF2ERTrm8Sj9/nAGWImxkj/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm2YWo7D9rU0+nRLWSVoq1VTT7ZnKgXtTeas0QTYg4Q=;
 b=MiKWNcU+N6LlEmlbKaMgbZI4nmIZLpBSh0E8TWvKnVxfFG3ZrWn+P4TqP4yIK4g2Tl45qInvDFx8gI5xCsluK68WXOq32YFlQ0gryqeOs8+KEy9N4ZRP7a/eG7ZHJVkcYbqUlsrb7ANYbQeZ14ch9RK2fBNBnyfdhzGjHQ4KHGg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 22:31:23 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 22:31:23 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Propagate core init errors to UDC
 during pullup
Thread-Topic: [PATCH] usb: dwc3: gadget: Propagate core init errors to UDC
 during pullup
Thread-Index: AQHZnscRxYdAzlx3Gkm9Jifuq9rRaK+McysAgAABewA=
Date:   Thu, 15 Jun 2023 22:31:23 +0000
Message-ID: <20230615223118.n7mekntjk3qzop4b@synopsys.com>
References: <20230614134922.23516-1-quic_kriskura@quicinc.com>
 <20230615222600.er6i6dllmxwylnbf@synopsys.com>
In-Reply-To: <20230615222600.er6i6dllmxwylnbf@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB5327:EE_
x-ms-office365-filtering-correlation-id: 31cccca5-2f69-4426-930f-08db6df03ffe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vNfICC34iSGbvTAXoptw0jO7lZzGheE5tKCprtfM9P5BamCsP2HLDxWX+Ch6/lM65lsFEPi3op4GAVC4vTBpa2dI0yAPorVUeKc3eWWw+N/Rrx0Q2E5/9bi/cNzuYnc3ZlXjoLIPlv8j5bsNFKyjNU1b+iemH1vNdJEGlLoxMP1erXszaEd7MLSHNxpxeIccehdiJOoN3dChVWABxrP9W63FHarC+Qi5w7Fl1ohdMfyIxTcsHRRjIBRVEgvb8E/RQQbv/dmOfz6/zzk9XnkPEmVyJstz3pxxuVHeIONWlZnAqyK964GRkOXcsuN5465e7mDLlshYYSBBKEKJSnxu8Cv+ukJURq2r+4FmqM121V4ox5S8HjcUD7ZZ1IUCcF4/vpDDmyRv/5OXR74e5P6u9O2wBTxDU+VMOGbavVORshOrBrGzjT38bQnmNvlaXGJ//kFvn3oJD1B4oDrVv1ycUbTKAxNgX3Ia7YMxx+aRVcbwjRglWGou4cxBGom5Zj2KlMeMq3NAG9EaUJbXCad3p7ljaYU4h/nWK+5siOEqgSDktSKRPgk7J/8OD0G3yzuRhSTx47RgUioF2ZOIuNNKe7LQvYCSOiSPMQeyTeq8RCsQMU+iNukgyvdbNQiLaP/v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(54906003)(8676002)(41300700001)(86362001)(64756008)(66556008)(8936002)(6486002)(66446008)(6916009)(66946007)(66476007)(316002)(71200400001)(36756003)(76116006)(4326008)(38070700005)(478600001)(26005)(6512007)(5660300002)(83380400001)(6506007)(1076003)(2906002)(186003)(38100700002)(2616005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFVrejlBUmZ2SE5NL3pER2dhbm01N1M0Qk9DNkUrN3FEWjlxbVJ6RVJhaE1J?=
 =?utf-8?B?bHJrb0hCUzFONDNJVm1lZkQ3MVhHdU1YcURPTktxcCtIVGdaRFhwQnBVRVhp?=
 =?utf-8?B?YjEwQ1FYNWJFTmJMZm9qK0hGZ2lnTnJpNFRZQnVlc0ppYVZmU1VNV1lnZ1Mz?=
 =?utf-8?B?ZlBzK0JGRk5EMnVTaTBHdkxMVnhmVm1LYmNZcEFObkttL0oxRkhuay9QMGdB?=
 =?utf-8?B?YnJ6MENsQ0dsaDBzc284cUZxZnFhYVh4ek8xd1JJSFBuaDNtMEtsZ1BHMVpl?=
 =?utf-8?B?bTlvVVRGRUs2QVRUUWFCQjNKMy9Ea0lNNFo0WkgzS0tqSUo4cXVmYk9LUHFh?=
 =?utf-8?B?VGhHMUlFYTU5MzBMWHJaZkYxenp5aUNsR21aZXQ2TE9kbDduNDY4cEpFRGRh?=
 =?utf-8?B?d0lrZGVOdTN5bnQ2T0tlLzVzMjRud1RwckVZY2p3LzB3eXdHTXpDU05nL3FT?=
 =?utf-8?B?elppalZJaTRJZVRuUmYzOFVxelRMMG5XQm8zVnM1SmtrdU5qS2N6UHBvRTdR?=
 =?utf-8?B?MGlGZ3dScnRRZDgwaVpzTTJvVmNPb2drQytuU0dxeGZxNXYvWVhLOFNraDNt?=
 =?utf-8?B?THJMOEFBR3hhNTNQSndoNmVjc29YeWJFeCtOZlJFQTRlaDZjU1ZlWXo4Zk94?=
 =?utf-8?B?RVNTYnNEMnRNeGV6SzhHZ2ZPWTZ3RmNvMkVBSEhiL3QzUy9MeWhHT0JFdVhp?=
 =?utf-8?B?SFVvL0JIN2VBbFRWd3hVR3FSLzN6YlF0RDBHb3ZTeTV2bDcwL1RsaWNvdVBX?=
 =?utf-8?B?aHVQRzk0ZTZaUjZ6UzJpenpieFhuVStDZ3lGQis2SmNNRDJ2NGVva2x0T2Ir?=
 =?utf-8?B?YzlLUnpKSEdialRmd01MRk5uVTN1NU5OYkFDcGxNMGZQblcrVzFGZm0wanR4?=
 =?utf-8?B?WHdJTlQ2ZzdtaEVVSEhlaVoxZFJ4dG43YjdZZHFtMWRWQUhNWmJvVC9MTXJr?=
 =?utf-8?B?SXBVUkpwSHp1ZDQreGZqenBlSlN5YmlpbXMvOXdvd0ZoOGovV1hWdXc0cjU3?=
 =?utf-8?B?UVlNb2RqT0xueFo1UkxZcXNEUnZHWFZUTHhrUTlKYkZhMENyd0p4QW0xK2VY?=
 =?utf-8?B?TFEreExTa0lTaDRSQ3A0b3RCM01aVDB0REhmMTc3Z0FoLzJaU2Y1ZEVjbldq?=
 =?utf-8?B?RjN6U0tqTThxVThWVlg3YnhFcW1FUDZBNjZnckpROUR2emlkM3hobllQeGIr?=
 =?utf-8?B?a2MzbFl1bEszOHdZeFdIaU1tT3hrQURkaktSZFJ5UlBVMkZwaWJySHRoYjVI?=
 =?utf-8?B?WUtOUWtsQUg1dGVBYlVaNEFzdUgwbks3K2MxS0cwajk1em9FRkJTQ1R6Z2hN?=
 =?utf-8?B?NzdBN0FlaTUyZXcvLzluY2I5S2dmdjhzMWlQWTU2SVU1SGo3T2dpNHcrR293?=
 =?utf-8?B?N3ArVE5vTEhpT0ZmUmVPNWpvVkNSTzJvc3pkbzZRODFoRlRnT0RSc1RYbjRx?=
 =?utf-8?B?ZU9VbjJXQng5a2tJWjlVWkl6OEMrOC9oK1kzb00xV0YwTURlNFpkSmdDalJT?=
 =?utf-8?B?Kzhxa0Y4SUg1dkh6ckdkeHNlTC9WS29Jb0FDdlhHWUR6T0NFb2hPbmtkT0lm?=
 =?utf-8?B?ZHRLdTJsZnM5Zys1aGdzKzNXYXNubmJHMWpqa1B5WHo1VjVTaEhwOGlZVE1I?=
 =?utf-8?B?c2F3RGdkMmdmeVQ0aENxWEhnN3JTTjIyTTRFNGxCcWo4UFFnTnpvVGN5VnBS?=
 =?utf-8?B?V0x6RWdGclVMRlkzRFVIRk9Ub0xCTXlCQXJWVWtxTVY0L0lsbjIzYVBoUXho?=
 =?utf-8?B?T0ZVL29MR08zMVhDUGFFUzQ1cHBEQ1JBenVFcVM0bk1vNnZNVHBaOFpGU21X?=
 =?utf-8?B?bklZTU1ETEpuRGJwMk4zcHI4QUJ4dC85ckp6R2F5ZmJGaGxUaDhGWEluYW85?=
 =?utf-8?B?WXdMWEhzSjA5UHdOSDRMQXpsdlo1Tnc1S3kzMmVObFdvUjdpaXlBTWM0UGpn?=
 =?utf-8?B?R3RST2JxeUd5YldaTjd0MTJDRUg5VWlVc0I0QVZONFZaWG93TFcyS09QRW9u?=
 =?utf-8?B?LzJ6dHIxS2NLa3N5ZTB0c25wMndkQ0VremJhWlZ2a2VrVTd1MXVBRlZaOU9Z?=
 =?utf-8?B?U2dxZHlBSE5tdUtvcExiVzR6Qjk0b0NVNUsxc1FOUWNGYXM5SXAvV3RKWUVM?=
 =?utf-8?Q?/NPkF4EOhFoAiNoByswpzlD3E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95320154551CAA439F281D464C6A1F43@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vfekKCac/AFSV/erHLIlhachVenSVQyx2BWbNx8Kb6LyXiGTXbRQbXCIV3/Ac8r7fwDyYXMzhQ6WA3crx3GguEBcJjV/hm/mwNR/5KR/KPa/r3DeDjAW25CXIo8Dq7Qs8qDsW/VxTaWQjnOS5OF/2VgyFhn7vaRIAs08a8bdhKXzezPcW4MgFLM+tEN7kd2MSqegyxaootePzKXMzy0WtS1zvBxHRDFWNty1brN9IUGxMge2IjVRhksBmKMqJn+cIiz4mHGSpLpCYVCGN2purZqtH+A9ETAKML31/JY41s9Z+/yO/Rxt7+abJe0u0EQPpcVfzP0UZhetNXk+OxNQbEYHtjn5BoD0T+nR7bVgtJu8cHf/3PQMs5tZZ0RtXcRybMiTs0RTa4/XkR/RyU1vRw1+5SGJAuKR3YnjFzSzI6TWsnrEaLDASzrd3oDV/CCdCvb80IwH8MvUvy+rwSozykLqOgGPrTNBOUCiz7Yif91AmXfrZQdjREzFokWDWyQDWCQdOn7h1KuD2Hr/tZHGefDx1lRqDxIq+Y9njG9uQLcBRVr9LrBga+Aq5S+mzx55KIMYCa+K24oLNRJozLSQYhNHUWsaPX0zqt4svDBTCZLIo4fH8KVr1QnANsU1h35SxfXzJOG/uaBpVVxFZ/moikix1sFy0cE0n7dO5aY2hMa0ahAPlB2UjKgP2WseQ8+ZxwGBcJjUF2bmQsrbbLco+Gek+GoQyLfbcxklRhvUVZIJFzfuFjRryoyZYEUpIZy1ZfKpBPt+kR9JIA8KHMZiubibgiVTP1sidKQXcbH5h9rk+8rIJbwOoQF9l7DZ/P/hmSiAOIdcCgL/vUvxmGfUNUWDZpZ9s3/sHYclhe8WKS4QOVRezSjDlJ0dtakgfEwNKKAI465Qqt/kH5CxsUUHlA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cccca5-2f69-4426-930f-08db6df03ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 22:31:23.6200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1YJvaiXYNarq/G2r0J/4O47Hj7y0+Bga7RxwWMuh2zqfEzWFz14GyadZoICxnF/5uvdUM3/8R3hvL0rwUtlZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
X-Proofpoint-GUID: 5Zc0pMh4Xstn16aLsR1IXlF8c4Z_tMZf
X-Proofpoint-ORIG-GUID: 5Zc0pMh4Xstn16aLsR1IXlF8c4Z_tMZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_17,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=926 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdW4gMTUsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gV2VkLCBKdW4g
MTQsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+ID4gSW4gc2NlbmFyaW9zIHdoZXJl
IHB1bGx1cCByZWxpZXMgb24gcmVzdW1lIChnZXQgc3luYykgdG8gaW5pdGlhbGl6ZQ0KPiA+IHRo
ZSBjb250cm9sbGVyIGFuZCBzZXQgdGhlIHJ1biBzdG9wIGJpdCwgdGhlbiBjb3JlX2luaXQgaXMg
Zm9sbG93ZWQgYnkNCj4gPiBnYWRnZXRfcmVzdW1lIHdoaWNoIHdpbGwgZXZlbnR1YWxseSBzZXQg
cnVuIHN0b3AgYml0Lg0KPiA+IA0KPiA+IEJ1dCBpbiBjYXNlcyB3aGVyZSB0aGUgY29yZV9pbml0
IGZhaWxzLCB0aGUgcmV0dXJuIHZhbHVlIGlzIG5vdCBzZW50DQo+ID4gYmFjayB0byB1ZGMgYXBw
cm9wcmlhdGVseS4gU28gYWNjb3JkaW5nIHRvIFVEQyB0aGUgY29udHJvbGxlciBoYXMNCj4gPiBz
dGFydGVkIGJ1dCBpbiByZWFsaXR5IHdlIG5ldmVyIHNldCB0aGUgcnVuIHN0b3AgYml0Lg0KPiA+
IA0KPiA+IE9uIHN5c3RlbXMgbGlrZSBBbmRyb2lkLCB0aGVyZSBhcmUgdWV2ZW50cyBzZW50IHRv
IEhBTCBkZXBlbmRpbmcgb24NCj4gPiB3aGV0aGVyIHRoZSBjb25maWdmc19iaW5kIC8gY29uZmln
ZnNfZGlzY29ubmVjdCB3ZXJlIGludm9rZWQuIEluIHRoZQ0KPiA+IGFib3ZlIG1lbnRpb25lZCBz
Y25lbmFyaW8sIGlmIHRoZSBjb3JlIGluaXQgZmFpbHMsIHRoZSBydW4gc3RvcCB3b24ndA0KPiA+
IGJlIHNldCBhbmQgdGhlIGNhYmxlIHBsdWctb3V0IHdvbid0IHJlc3VsdCBpbiBnZW5lcmF0aW9u
IG9mIGFueQ0KPiA+IGRpc2Nvbm5lY3QgZXZlbnQgYW5kIHVzZXJzcGFjZSB3b3VsZCBuZXZlciBn
ZXQgYW55IHVldmVudCByZWdhcmRpbmcNCj4gPiBjYWJsZSBwbHVnIG91dCBhbmQgd2UgbmV2ZXIg
Y2FsbCBwdWxsdXAoMCkgYWdhaW4uIEZ1cnRoZXJtb3JlIG5vbmUgb2YNCj4gPiB0aGUgbmV4dCBQ
bHVnLUluL1BsdWctT3V0J3Mgd291bGQgYmUga25vd24gdG8gY29uZmlnZnMuDQo+ID4gDQo+ID4g
UmV0dXJuIGJhY2sgdGhlIGFwcHJvcHJpYXRlIHJlc3VsdCB0byBVREMgdG8gbGV0IHRoZSB1c2Vy
c3BhY2UvDQo+ID4gY29uZmlnZnMga25vdyB0aGF0IHRoZSBwdWxsdXAgZmFpbGVkIHNvIHRoZXkg
Y2FuIHRha2UgYXBwcm9wcmlhdGUNCj4gPiBhY3Rpb24uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDQgKysrLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+ID4gaW5kZXggNTc4ODA0ZGMyOWNhLi4yN2NiNjcxZTE4ZTMgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMNCj4gPiBAQCAtMjc0Nyw3ICsyNzQ3LDkgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9w
dWxsdXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBpc19vbikNCj4gPiAgCXJldCA9IHBtX3J1
bnRpbWVfZ2V0X3N5bmMoZHdjLT5kZXYpOw0KPiA+ICAJaWYgKCFyZXQgfHwgcmV0IDwgMCkgew0K
PiA+ICAJCXBtX3J1bnRpbWVfcHV0KGR3Yy0+ZGV2KTsNCj4gPiAtCQlyZXR1cm4gMDsNCj4gPiAr
CQlpZiAocmV0IDwgMCkNCj4gPiArCQkJcG1fcnVudGltZV9zZXRfc3VzcGVuZGVkKGR3Yy0+ZGV2
KTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+ICANCj4gPiAgCWlmIChkd2MtPnB1
bGx1cHNfY29ubmVjdGVkID09IGlzX29uKSB7DQo+ID4gLS0gDQo+ID4gMi40MC4wDQo+ID4gDQo+
IA0KPiBBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0K
PiANCg0KSSB0aGluayB0aGlzIHBhdGNoIHF1YWxpZmllcyBhcyBhIGZpeC4gQ2FuIHlvdSBhbHNv
IGFkZCBhIGZpeGVzIHRhZz8NCg0KVGhhbmtzIQ0KVGhpbmg=
