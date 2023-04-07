Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41B56DA6B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbjDGAsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDGAsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:48:12 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456AB7282;
        Thu,  6 Apr 2023 17:48:10 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336LMnfT023708;
        Thu, 6 Apr 2023 17:47:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=dXHcSb8OZD+vFTNe1TyS8Wy0jxNFGK+BVmtHnY836BI=;
 b=Gx+0JU2nAvXw32XxcKKLhjJ/GNrUtvR1A0sVkXihpvGAbhIgZ94UlGbDGrtY1DSGSbO3
 vY+1QL1AvuERmMYsfzU7/oheZ3EE0hbHGpa61LCYAslH7CJmNL03ICPXocTagEpPNz46
 jOFngmxFIRJN7zANDf1fprfsxXU0G1Rf0LAfWmU3MgGdYqmu9oE/58aDez8e5uNUvgnx
 Uzs2KNbfTGHwewAaTfmVmzj5XqqkDquF3XxbqjICwUZaSkHIfTymSukW9BBBpq/mUGbl
 0HiM1sWNggmkmv52bR2iNTT37QKyE/MW95xYT6f/vBaBzvDJf4tgBX0knDPvfKDElCik nw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkhy1h76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 17:47:59 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 775F4C04C2;
        Fri,  7 Apr 2023 00:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680828478; bh=dXHcSb8OZD+vFTNe1TyS8Wy0jxNFGK+BVmtHnY836BI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZLjOcdoL3segGizTF2WHKRNDKDlJ4Gxo58jR9q5mDk0JdkpUUS5nF/l1cK1XyITpa
         N81voVsVlKjjdTLpPNBf2i4oQIVlOpQnmCXGPSB1vuBJRlmHycpoNdg859JHo0fjxV
         N0DxHUYG4boM6iptGPZl1x4qjuKdOi53mHjJrAvjMhInk22xXUevi/F70A9do/5qt1
         DlsGc2jbj+9iytYqmRprsdo29ctSWtMtur/V9qiciOofKxSvxHnsC83AR+c3eSd2BH
         Ht5nFsyInllenq27PTv2/gFnFnhABlytYAI4qs64QpoAQ2X/9EkVu/GaJLCGh4EKvE
         5n4lgRq7xK97A==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3876EA007A;
        Fri,  7 Apr 2023 00:47:58 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CE4FE800BD;
        Fri,  7 Apr 2023 00:47:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="AEMEZVbC";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyphDqW8nR9/mZtQKEkUVSx2cdpF59E+1vZTJ77ePswu6xbgYkptcTCwvplSimE7eMjr4571L1S6bRt6kCPUm94bFWQYw6tBCG1GWUaxZ/laX0Ar/Q4B/12cksd0ocHro/oPtu16Tj8je4zWtxxyv+BSJjN9RHlOLVMfQkOWvmSe9niGLmXodbMFBsBo9aR7QdJo2bEZL5ac8m445DijAcpYTXbnO3aek6rNlzGSXP7lk6G6VYoVGVFkUtFEs1xuCyecKpbDDVmsuS2WD4WkrcsM00KxFbG5APAmwDo4kdQ9cZSvCGhoJwCew00ohkGM5h6c9t5KfXLGqw7sE/X1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXHcSb8OZD+vFTNe1TyS8Wy0jxNFGK+BVmtHnY836BI=;
 b=mR78P2mkQ8Ad0GVdLJ/2re9ckfTEdATucrGZJmHKsyqw/uLqauNO7MfTrFd7b5zCmUVBziHdS0IBHv2WLjq9sDxzdJIzWyJu9obiQOIo3O7WLRs17c3k321OFWr/gNA1q3zSywB73hwp4ikZst+9EyBXl1EwJA6TKg5ZGN16/lxWCF87bOFZufKf9XPaN29XAHVRS30aXPoMqIp1ehaoFJfWfMLSTf/BbmUfDAWRY/YFIfliXS9H9ebwBsXCm1akl2DvsLkztk4+6U/c0/CTELzh5LJ0osxEVDrMNJlxwqzko+CjXsL1gxpJSoaxNC+qkuKU/WjmRsfbA2rigXZIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXHcSb8OZD+vFTNe1TyS8Wy0jxNFGK+BVmtHnY836BI=;
 b=AEMEZVbCyYWdOQ3be5fRSKpSr0C7xqrQLRCsHOthSeYyBfmcKE7d7ETWtjCaPlaUfGMBdYyvhx65KilpK4Np4FhlI+Bw7l/5iCjif60PKqEq1gzB6ssSophlwfCsTelmfUIbrsqL6gErCgmxMwGuMqYIlBC72vhjd3zlUsKzSvU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Fri, 7 Apr
 2023 00:47:53 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 00:47:53 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/11] USB: dwc3: refactor clock lookups
Thread-Topic: [PATCH 10/11] USB: dwc3: refactor clock lookups
Thread-Index: AQHZZsawLjGe1WE6XU2WnA9yYePO468fB44A
Date:   Fri, 7 Apr 2023 00:47:53 +0000
Message-ID: <20230407004740.ldyigffce7jldaug@synopsys.com>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
 <20230404072524.19014-11-johan+linaro@kernel.org>
In-Reply-To: <20230404072524.19014-11-johan+linaro@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY5PR12MB6432:EE_
x-ms-office365-filtering-correlation-id: c04bd250-0200-4695-5ad8-08db3701b873
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /zkx5OZ4J87/LgD0KK7eTOYmLuQwdzWgmmD26tkm9C3/QQaAwn6UTHVkm08KE+rEm3e+w4Df7q7Mc7r1XkfimLVf9I5AEWgxUIXwvEvwKjv10wttldKW+iGDlhJiIso++kV+9NYm1cPYDKldQ9zk38s+X+Zr+kvS2Pg6TW7VUx2kww0qsZZjtSbrmHczR+LSZFpA3MSiNlHCe9AAGyMjIVJ3IK/Zg1a6sDDU13QiQU2GM18hLpaUvrZ+ALt2ziLFz2Dzpb1HFJ5Bsp6BNRH+E4kVI/7tCRzEJ6rtvzwZmqgQDXYEQXgap0iC9WfYKv80BkIzJi/fLuwnETT8qGjHzVZV/4P9/dPWGwTwmDH+uHAP3tpASULTF72nPnfLY0p+4kEkYsWF4ptetzz6qYWiE1KrJOsfikXl704GSwz0TmHYQT55FwKspHF4t35opFyEahQ4HOjSTs15U2S2oqJtP2FwDc2i7FEYTzICvqr8i+m2k1zyK9ko5X1feNpECXlDifHdcAOLLaMXvIMDXfQMLNtxA58cHBF3EZrbWzhIZqHEdlJWFDO1h3nn3eSDzs56r6mXq4YBpWU7UKjS7FpHwLNSy395R0XvVrGZN0v7+TeZ4k9BV96MudCuzJXkT6zd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(478600001)(66446008)(86362001)(64756008)(316002)(41300700001)(66476007)(66556008)(66946007)(76116006)(54906003)(4326008)(186003)(83380400001)(2616005)(71200400001)(6486002)(1076003)(6512007)(122000001)(6506007)(26005)(8676002)(2906002)(8936002)(5660300002)(36756003)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFF0Mkg1RXNYbGF5R0ZGMzFFRWtuVitRcUNMODJKbGIzSys2TEtuVUxQRytm?=
 =?utf-8?B?QkFUOFo4NHpVQ2tTWFA4VTRCdWxabFlCaUdQeThtMWtpVGFwMXpHMk4wUnRw?=
 =?utf-8?B?Rit3a2p2cHNHa1F6RE55MUVzbWRFTlFianRuZXpYQkpPRTM4Wmt0SmhZaHY3?=
 =?utf-8?B?NnJ0QmFDbUovbHNHSWJEQWVGRjRPSmJEeDZKSTRzbllTbjMxZ1QrKzV3S2pB?=
 =?utf-8?B?ZE5LaXRUMENJNC9ZZHRZeVpIaExaNFdKbEZVQmZ0dFBpSXZTT2plcEhjdVJV?=
 =?utf-8?B?bVRHYlpSTkk1NGpkWXF5L25LWG50bUlxNWhLYVRteTlSUEtJM0l6UFZ2MHl1?=
 =?utf-8?B?OERSc1NWVTJiYVA3NlRYODZNbnZISDVKbmFjWElSeTFpc1c4akFiMmhoS3ll?=
 =?utf-8?B?Z280K2ZydWR6ZFFDRVhDMTJDcFRLVkExcXZZbVlDOU5ueHUyVFdCbENSdDVB?=
 =?utf-8?B?dHgvVVNjdnZYVFVseHYwT2VZQVlITS93eEVPRFRGcVB1UmQyOEtRK3oyWWxv?=
 =?utf-8?B?SWRPQWkzVVA0V05sMmhVTC83Wk1jNWNTT0d3dldjdUtWWExuSXk3ZmlKTVBH?=
 =?utf-8?B?b3BnaEh4KzM0dFExVnZUakt1emNjQ2NTczNDQzBJVjkvZGk3TUxVSEl4aHNY?=
 =?utf-8?B?aHBGbm40TU5DaWdTMHdydVJySmxzSjNZanhwdGwwV0tSRHBoTEo2RnJkTUZH?=
 =?utf-8?B?SDRLSkR6Rmg2MS9KeUFNUXhQdENFYkJuR3FsRmZKTG9GOGhQYTY4YllqK2tr?=
 =?utf-8?B?dk5UNHBHaFhVc0dSOVg1TGxWUHErazRyUDZFc1JSZXM0c3R6QWZ6MHU5Wkhm?=
 =?utf-8?B?Y2p5cThJOFJjMnJWTjU0UFJ0dFNJU05TN2ttQ1NjL0Q3RDhKaUtvUnBlNFpG?=
 =?utf-8?B?NTV0SXhpUVVlcjRLT2F5ejI2dUtKcjVHMEZIWVhTTzlreGl1SzY2UDd6aDVs?=
 =?utf-8?B?WGVMb0pNalhIb2VIYmhLS0RpNTdvMlcxQjJsWFdRTE9JeWpIdG9uaWFZWEky?=
 =?utf-8?B?TlF3VjdMUnIwUzNJd0dFc0QvcnhqUWVUNEFpTHRCbUpuVDV1T3EvbTRHS0xi?=
 =?utf-8?B?OUZjaHRCOEhoN2VFamFoT09GS3hSaFBOMnJJVjVJMmVkMFhuMUF5bS93bXNo?=
 =?utf-8?B?RGh2NWkzeFJxYytveTJnQlFoVDNTNm1UMkxRTTBOUEs0K09lZXh5U0xvSHo3?=
 =?utf-8?B?bDFuQysvMFQwK0IxMFAzYlM1UUxOS084ZGg2NUFOUkVwNU9VellJaVJJRlBW?=
 =?utf-8?B?Ym1iK1VCaTRWcHRjMVFTNlR1UmY2UmNMeGhsZ3VyNTBuclk0Tmg5SS9QSXZJ?=
 =?utf-8?B?VzVqcWNsWFZjdE4wZFBkMGtPTC8zUUl4ckVFdVdJYlRaMWxXNDJLZ20zY2dF?=
 =?utf-8?B?NUpiWHBzMmZuOHRPanpRaUp5K0hocVBaR25TdEhyVi83QkpOQ1FrdExqTlo2?=
 =?utf-8?B?WnJhOW44NEdvQmNJMnU5NFZwRitHRmlHTDBxUVZ1TTlwa2szR2Q0MC8wYzE4?=
 =?utf-8?B?VWQ3U2tOSlZhWWQyYy9ZTGJWZmJYV2s1cVFGck1GbFFScGJtRktDSVdXKzIz?=
 =?utf-8?B?aFRqOVVoaFEyaVpER2E5K2toVld5d3BJbjQ0NklCcFNsa01iL200QnM1WGZs?=
 =?utf-8?B?eW9SbVhpOXNrTjFvVnUrVE5zR2ZVUW1qa3FrblRRdTNTcnA2b0Nhd1RvU1lD?=
 =?utf-8?B?QWZieThnbHArRnJGbThmbi9nOHNzMWxwbXhJYUY1NGFDbTYxbHBZTFdidGpL?=
 =?utf-8?B?VTVXU21uQksrMHV3Und0RU9QSkx2OGI5YkVQOCsxdXRzY294MUNKaGs2RlBk?=
 =?utf-8?B?cmowVkEvYmtaVzNUc04zblFXN3IzMmVMc0RucXRLaDlraU1SYURMVFdlZFlW?=
 =?utf-8?B?ZkNMZjVTOE5iVlRqNmVIVExkajFZdGpjd3dMMVNZRGZILzlwUm9VQVphdjJq?=
 =?utf-8?B?UTE3UXNZb1kzQjhBTENiNUh4VEhSbDNyTUp3M1JSME9abGM5VEo0SkxWanl0?=
 =?utf-8?B?UzYvcTRMRmhUTEhDV0tNdDhLNDU4b0VwVTFiNUZpZlJuM1g3Z2dNcnhHM0Fq?=
 =?utf-8?B?ZjNkMUtIYmsvaU15M3dtOXU5bmpuMnZsc2hzRWE3Y2pYSVhLL2c0MkNaTE1o?=
 =?utf-8?Q?lDM9lGMhL/jWItE9um5ujCfca?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06C7AD36FCBA04469F9F29228E957D47@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SBOIAtj1oDbAcERvrdjhCbR+oXTzoZPExWOrFnFygscyqICukezloMw2xoo9eqF/RdI47TxARHpXYdCGdfwhTLEnFVzhlxUz97YSyvSf5ul+1bT2lruGWDr21AhGtbEiib/BraLbSfBvb2/C+YYyw4ispCIEEs5f+6hHe1WAV2kGl9RXGFh6ZA8cNuylxWwDveFiOVrFP5fuLWuhGmCDrRFVfou3ZiAOfKxKLN3E0xsQJFsAptGv5wIYYlZ11D4pkAKj/ah/fZVJe8TbBR7pKaPCpRId4Ip5fgv3XKJfjHPzqHRuBKDuQORA9imV1F4LPTfocT2rNfDPzPS95NhhoLI5MPWHmnOo9ZytPtfbOgAzb4InknFi1iD7iNZPtRd0TaAD86lEyfxzLyl02LbT/uaC0pg3+VpYxKtbMhp+jRM69XsO8k1t0zeWg0OAbHJ++wHBoiZqpQa+wTI/QDk7OgxrdT/NrBNFSg5hewbADoCzgBe8O4FtmMtvxZzQZ3YpP2Bbr0r5iQXplDvILWD9C1dCIXTWSF/KqjHu560WcGcrxQSnd6RnQUq5E/vjvh7PEYcoSLcHjHLy7lZRO+UqVmSXHhzOE+SDS+mGUYHdeA6q4Sg6tRf0ufQ5GWC5UTZGZEyouADu1gMuM4F1clE/SMUEVrIIomqcKWXARu6CfNr8y5Bzd+6tX6GCFwDm/lvTE76ez0tLrJ9Y4Ck21smFbEDM9l/xksCgoHjPpiMHHSixwycCOSEp5uruLKoPfYq1V8WNCl6dmVRnh/QT0l9tUi1cGRy83AMHEZS8jpcLl4t4U0jzvS5z0DupwqCnrFhCj+q+eF+AMIboa+IUnFamMlN+1IqyJq3JZ9uw+jYPY7zzhZ/lZH/ifFmtx3Q0ftou
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04bd250-0200-4695-5ad8-08db3701b873
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 00:47:53.1984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzWlzx1fxLXKWtyj6SNTJzK2ekYXWX4wAYygZkT+2UChmFt7NaG8SSOlm8gSU0Y2MTthpwScjTRbkAzokHEM5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432
X-Proofpoint-GUID: P20aAElRpGiAEtd9twZNsIbBTte1CQFF
X-Proofpoint-ORIG-GUID: P20aAElRpGiAEtd9twZNsIbBTte1CQFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070005
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gVGhlIHByb2JlIGNh
bGxiYWNrIGhhcyBiZWNvbWUgdW53aWVsZHkgc28gYnJlYWsgb3V0IHRoZSBjbG9jayBsb29rdXBz
DQo+IGludG8gYSBuZXcgaGVscGVyIGZ1bmN0aW9uIHRvIGltcHJvdmUgcmVhZGFiaWxpdHkuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbiBIb3ZvbGQgPGpvaGFuK2xpbmFyb0BrZXJuZWwub3Jn
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMTE2ICsrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2MSBpbnNlcnRp
b25zKCspLCA1NSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDUyY2Q1ZGRmZWJk
NS4uMDg0MzJlMTA5YTNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0K
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMTY5Miw2ICsxNjkyLDY0IEBA
IHN0YXRpYyBzdHJ1Y3QgZXh0Y29uX2RldiAqZHdjM19nZXRfZXh0Y29uKHN0cnVjdCBkd2MzICpk
d2MpDQo+ICAJcmV0dXJuIGVkZXY7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgZHdjM19nZXRf
Y2xvY2tzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICt7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0g
ZHdjLT5kZXY7DQo+ICsNCj4gKwlpZiAoIWRldi0+b2Zfbm9kZSkNCj4gKwkJcmV0dXJuIDA7DQo+
ICsNCj4gKwkvKg0KPiArCSAqIENsb2NrcyBhcmUgb3B0aW9uYWwsIGJ1dCBuZXcgRFQgcGxhdGZv
cm1zIHNob3VsZCBzdXBwb3J0IGFsbCBjbG9ja3MNCj4gKwkgKiBhcyByZXF1aXJlZCBieSB0aGUg
RFQtYmluZGluZy4NCj4gKwkgKiBTb21lIGRldmljZXMgaGF2ZSBkaWZmZXJlbnQgY2xvY2sgbmFt
ZXMgaW4gbGVnYWN5IGRldmljZSB0cmVlcywNCj4gKwkgKiBjaGVjayBmb3IgdGhlbSB0byByZXRh
aW4gYmFja3dhcmRzIGNvbXBhdGliaWxpdHkuDQo+ICsJICovDQo+ICsJZHdjLT5idXNfY2xrID0g
ZGV2bV9jbGtfZ2V0X29wdGlvbmFsKGRldiwgImJ1c19lYXJseSIpOw0KPiArCWlmIChJU19FUlIo
ZHdjLT5idXNfY2xrKSkgew0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIo
ZHdjLT5idXNfY2xrKSwNCj4gKwkJCQkiY291bGQgbm90IGdldCBidXMgY2xvY2tcbiIpOw0KPiAr
CX0NCj4gKw0KPiArCWlmIChkd2MtPmJ1c19jbGsgPT0gTlVMTCkgew0KPiArCQlkd2MtPmJ1c19j
bGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoZGV2LCAiYnVzX2NsayIpOw0KPiArCQlpZiAoSVNf
RVJSKGR3Yy0+YnVzX2NsaykpIHsNCj4gKwkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRS
X0VSUihkd2MtPmJ1c19jbGspLA0KPiArCQkJCQkiY291bGQgbm90IGdldCBidXMgY2xvY2tcbiIp
Ow0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICsJZHdjLT5yZWZfY2xrID0gZGV2bV9jbGtfZ2V0X29w
dGlvbmFsKGRldiwgInJlZiIpOw0KPiArCWlmIChJU19FUlIoZHdjLT5yZWZfY2xrKSkgew0KPiAr
CQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoZHdjLT5yZWZfY2xrKSwNCj4gKwkJ
CQkiY291bGQgbm90IGdldCByZWYgY2xvY2tcbiIpOw0KPiArCX0NCj4gKw0KPiArCWlmIChkd2Mt
PnJlZl9jbGsgPT0gTlVMTCkgew0KPiArCQlkd2MtPnJlZl9jbGsgPSBkZXZtX2Nsa19nZXRfb3B0
aW9uYWwoZGV2LCAicmVmX2NsayIpOw0KPiArCQlpZiAoSVNfRVJSKGR3Yy0+cmVmX2NsaykpIHsN
Cj4gKwkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihkd2MtPnJlZl9jbGspLA0K
PiArCQkJCQkiY291bGQgbm90IGdldCByZWYgY2xvY2tcbiIpOw0KPiArCQl9DQo+ICsJfQ0KPiAr
DQo+ICsJZHdjLT5zdXNwX2NsayA9IGRldm1fY2xrX2dldF9vcHRpb25hbChkZXYsICJzdXNwZW5k
Iik7DQo+ICsJaWYgKElTX0VSUihkd2MtPnN1c3BfY2xrKSkgew0KPiArCQlyZXR1cm4gZGV2X2Vy
cl9wcm9iZShkZXYsIFBUUl9FUlIoZHdjLT5zdXNwX2NsayksDQo+ICsJCQkJImNvdWxkIG5vdCBn
ZXQgc3VzcGVuZCBjbG9ja1xuIik7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKGR3Yy0+c3VzcF9jbGsg
PT0gTlVMTCkgew0KPiArCQlkd2MtPnN1c3BfY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKGRl
diwgInN1c3BlbmRfY2xrIik7DQo+ICsJCWlmIChJU19FUlIoZHdjLT5zdXNwX2NsaykpIHsNCj4g
KwkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihkd2MtPnN1c3BfY2xrKSwNCj4g
KwkJCQkJImNvdWxkIG5vdCBnZXQgc3VzcGVuZCBjbG9ja1xuIik7DQo+ICsJCX0NCj4gKwl9DQo+
ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZQkJKmRl
diA9ICZwZGV2LT5kZXY7DQo+IEBAIC0xNzQyLDYxICsxODAwLDkgQEAgc3RhdGljIGludCBkd2Mz
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCWdvdG8gZXJyX3B1dF9w
c3k7DQo+ICAJfQ0KPiAgDQo+IC0JaWYgKGRldi0+b2Zfbm9kZSkgew0KPiAtCQkvKg0KPiAtCQkg
KiBDbG9ja3MgYXJlIG9wdGlvbmFsLCBidXQgbmV3IERUIHBsYXRmb3JtcyBzaG91bGQgc3VwcG9y
dCBhbGwNCj4gLQkJICogY2xvY2tzIGFzIHJlcXVpcmVkIGJ5IHRoZSBEVC1iaW5kaW5nLg0KPiAt
CQkgKiBTb21lIGRldmljZXMgaGF2ZSBkaWZmZXJlbnQgY2xvY2sgbmFtZXMgaW4gbGVnYWN5IGRl
dmljZSB0cmVlcywNCj4gLQkJICogY2hlY2sgZm9yIHRoZW0gdG8gcmV0YWluIGJhY2t3YXJkcyBj
b21wYXRpYmlsaXR5Lg0KPiAtCQkgKi8NCj4gLQkJZHdjLT5idXNfY2xrID0gZGV2bV9jbGtfZ2V0
X29wdGlvbmFsKGRldiwgImJ1c19lYXJseSIpOw0KPiAtCQlpZiAoSVNfRVJSKGR3Yy0+YnVzX2Ns
aykpIHsNCj4gLQkJCXJldCA9IGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGR3Yy0+YnVzX2Ns
ayksDQo+IC0JCQkJCSAgICAiY291bGQgbm90IGdldCBidXMgY2xvY2tcbiIpOw0KPiAtCQkJZ290
byBlcnJfcHV0X3BzeTsNCj4gLQkJfQ0KPiAtDQo+IC0JCWlmIChkd2MtPmJ1c19jbGsgPT0gTlVM
TCkgew0KPiAtCQkJZHdjLT5idXNfY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKGRldiwgImJ1
c19jbGsiKTsNCj4gLQkJCWlmIChJU19FUlIoZHdjLT5idXNfY2xrKSkgew0KPiAtCQkJCXJldCA9
IGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGR3Yy0+YnVzX2NsayksDQo+IC0JCQkJCQkgICAg
ImNvdWxkIG5vdCBnZXQgYnVzIGNsb2NrXG4iKTsNCj4gLQkJCQlnb3RvIGVycl9wdXRfcHN5Ow0K
PiAtCQkJfQ0KPiAtCQl9DQo+IC0NCj4gLQkJZHdjLT5yZWZfY2xrID0gZGV2bV9jbGtfZ2V0X29w
dGlvbmFsKGRldiwgInJlZiIpOw0KPiAtCQlpZiAoSVNfRVJSKGR3Yy0+cmVmX2NsaykpIHsNCj4g
LQkJCXJldCA9IGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGR3Yy0+cmVmX2NsayksDQo+IC0J
CQkJCSAgICAiY291bGQgbm90IGdldCByZWYgY2xvY2tcbiIpOw0KPiAtCQkJZ290byBlcnJfcHV0
X3BzeTsNCj4gLQkJfQ0KPiAtDQo+IC0JCWlmIChkd2MtPnJlZl9jbGsgPT0gTlVMTCkgew0KPiAt
CQkJZHdjLT5yZWZfY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKGRldiwgInJlZl9jbGsiKTsN
Cj4gLQkJCWlmIChJU19FUlIoZHdjLT5yZWZfY2xrKSkgew0KPiAtCQkJCXJldCA9IGRldl9lcnJf
cHJvYmUoZGV2LCBQVFJfRVJSKGR3Yy0+cmVmX2NsayksDQo+IC0JCQkJCQkgICAgImNvdWxkIG5v
dCBnZXQgcmVmIGNsb2NrXG4iKTsNCj4gLQkJCQlnb3RvIGVycl9wdXRfcHN5Ow0KPiAtCQkJfQ0K
PiAtCQl9DQo+IC0NCj4gLQkJZHdjLT5zdXNwX2NsayA9IGRldm1fY2xrX2dldF9vcHRpb25hbChk
ZXYsICJzdXNwZW5kIik7DQo+IC0JCWlmIChJU19FUlIoZHdjLT5zdXNwX2NsaykpIHsNCj4gLQkJ
CXJldCA9IGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGR3Yy0+c3VzcF9jbGspLA0KPiAtCQkJ
CQkgICAgImNvdWxkIG5vdCBnZXQgc3VzcGVuZCBjbG9ja1xuIik7DQo+IC0JCQlnb3RvIGVycl9w
dXRfcHN5Ow0KPiAtCQl9DQo+IC0NCj4gLQkJaWYgKGR3Yy0+c3VzcF9jbGsgPT0gTlVMTCkgew0K
PiAtCQkJZHdjLT5zdXNwX2NsayA9IGRldm1fY2xrX2dldF9vcHRpb25hbChkZXYsICJzdXNwZW5k
X2NsayIpOw0KPiAtCQkJaWYgKElTX0VSUihkd2MtPnN1c3BfY2xrKSkgew0KPiAtCQkJCXJldCA9
IGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGR3Yy0+c3VzcF9jbGspLA0KPiAtCQkJCQkJICAg
ICJjb3VsZCBub3QgZ2V0IHN1c3BlbmQgY2xvY2tcbiIpOw0KPiAtCQkJCWdvdG8gZXJyX3B1dF9w
c3k7DQo+IC0JCQl9DQo+IC0JCX0NCj4gLQl9DQo+ICsJcmV0ID0gZHdjM19nZXRfY2xvY2tzKGR3
Yyk7DQo+ICsJaWYgKHJldCkNCj4gKwkJZ290byBlcnJfcHV0X3BzeTsNCj4gIA0KPiAgCXJldCA9
IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoZHdjLT5yZXNldCk7DQo+ICAJaWYgKHJldCkNCj4gLS0g
DQo+IDIuMzkuMg0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5
bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=
