Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7126DA6BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjDGA4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjDGA4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:56:42 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CFB93F4;
        Thu,  6 Apr 2023 17:56:40 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336NPZJ6025996;
        Thu, 6 Apr 2023 17:56:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=5TwsVwDH0KBPbaum9hNfW0hzef3kPV42TOk+WMtT7wk=;
 b=kK5IPX29t7P+5FqdLVzOArhraNLF72yaAQQiQ7TvW4CTsq3Qzi/lt8UVvxRT5eqeagx+
 3Yq3qOVTGvV9YKh0ac52YaDpNh17LYTeYRySKCUqchIlB653WjE9uj5buumpnougvBu+
 3IwZMHQ0TyFl31NmENA6GiS2qDWjwyrhDnhxCRjqK1Oqy9ZW9EsTg7ZHj6fAXdg9u8Qz
 52qNsIRw1E2aAe9SLeiXh44CVyIYUFHJUkiqch72gU+8nzYEUgUjTdfSbijNPibxz7W5
 2gXbq28XfzpSuXVLc3XoNqhxyDOM2qbUE2NL/f8oF9WCtju8hQtB/sv/vF2rNEYDzsWU zg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkmrwsej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 17:56:32 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 84BD6400B4;
        Fri,  7 Apr 2023 00:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680828992; bh=5TwsVwDH0KBPbaum9hNfW0hzef3kPV42TOk+WMtT7wk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=J81vnHu1ZxqtXXG48RhfenGmUjA+KiwTv6diJHNeR6KHZNUDQoFpyq+oat5JZHHZw
         jAN0UqkiUoUVObqdO8L8tijJcdqdYI1Ado3ROO4/PCptCb3P0sourjZ5yTVKZuud57
         ar6HLHG2/Ay9x4qEe8Qwu8IODI/mOnCF242394tAy5F5WitqAbhCAsxoEOLkKn+dOg
         qync9uq7rfysgLToBQRjQlDsa8NnvVxCCgNVEzKsl6laTuCfK6ztdIPsTTnA1iPTU6
         pthMWWvFMhYV6mQdWpYXyiSCdn8Pii3o/DwutymQjiknU0MiClNMugVkCL0L5xeaO/
         H6oerjVKwNnvw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 18F5DA00AB;
        Fri,  7 Apr 2023 00:56:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6FA304006C;
        Fri,  7 Apr 2023 00:56:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="OHslzDde";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUSV3SmYM0PyqFq69Ry3c7CugQiq353Elrk8UTx5wwADLjF4BoS3/6O/oTzG1bHE5G4OXGFOBo/FKYWnZjB5IZWbzGGTIc3Ef10nCW8kA5kjGmj1I1EqsrBdpc3ylkoO/YDQXemEYiD+ied7cWN4Fu1zn3mVzCH21XkcHbVsM5t0+kt/ONH8ipwoxdo1PZxDsvzvMpYdN60WSh+8XvkcG8LwY670lA/Gy2c/1X0+0VEGqr731nUt60UiggF9Unh0eV3BxtYaMPdpenJIdJnwPkKQCyTZwR/sdLsyf4J/vmGkC3k1p7oFdzR0ANMXRAxdMfUTgQCmyxJWR5ZvID/LzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TwsVwDH0KBPbaum9hNfW0hzef3kPV42TOk+WMtT7wk=;
 b=mXmJRZmlLyvBbDsysyU7QgAhefx30kzAhUY9B4xf1/IQLxNbeXdjDPJXiLHfOtPDcKmyjdkdb8KRs3GhhzaAqOACDG2c3oDPYQtm0nsA6SUrWyMSiP2W14DoRfg3xGp9iHuem7e3OcoWj3miB4w5qZ2IG7r9q6bqgKvdTHsKrVpS3JA9sl6bwYduS083reOR2hSb+iEMmJrEXCQ7B1Rze2UhsvtihP7OyJECCYwdNoWDmAWHs6y7xvBbe2zlavajWBnIMymVCGavJurJc7zj4Y7fExjGFvIRl3hoZ1MiOoP258tVkXHZicHO4yN1prSvugFrXktZORFyvNIIKqF0OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TwsVwDH0KBPbaum9hNfW0hzef3kPV42TOk+WMtT7wk=;
 b=OHslzDdezLcftour6UbWpFap7ovOIpdW7R1gnhxJEpKILd0gZTTP2vLOEmO9uUGxFSYn2UtGXe/OMZ4hH6ppHbA0QT1nSor1bQoXZRCzmD9mDoroWyeqYZu1eUwarWkIY4rsvKlgWmoDy+7/onC/z8Hykdg4o2wfVwa2Q/P6OnQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Fri, 7 Apr
 2023 00:56:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 00:56:27 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/11] USB: dwc3: clean up core init error handling
Thread-Topic: [PATCH 08/11] USB: dwc3: clean up core init error handling
Thread-Index: AQHZZsawvZmr2XXsWkK6Stum7aC1qq8fCfKA
Date:   Fri, 7 Apr 2023 00:56:27 +0000
Message-ID: <20230407005613.dbbfezhy3e6rqbvf@synopsys.com>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
 <20230404072524.19014-9-johan+linaro@kernel.org>
In-Reply-To: <20230404072524.19014-9-johan+linaro@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB8244:EE_
x-ms-office365-filtering-correlation-id: d9bc2c4a-ddfd-4a8a-297e-08db3702eaf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +vd294cZXmXfuApljOUyz+0V/lNOgz6F6X42aNf1eNWxOKYYjV+3je1+HnAqbBE5pNWdnGBQDqvZU9aAwSme7/duY3T8x/eVg3qXQPaQm9AJw6lWmf4D8g+DbdWRykxgwF47VvggcW6/GrHh131V27E0QEwFaETFLI++AxQq8VbPilVcB09G7yR4Of4uyfpJvWtC8AUD1mjVwHoTp0JeC3dK7wyMdE1aBI6JQ+tV6B+kqgD1Ih9hbaVLDzxAtyEpxHVvUhohYDrWJGtVcLt1dMYIlyP7P45QRCiY0vaUY0qU5iJGt9vVXU56kCZ4Yp+NjJ/VLNxYjzjoI0FxOLT9YQFz5qo81IFKhEXQ4g5fSvptj2n0Zf1+3Qzzq0Xx3p0UFzTyUsl+iNRlX176nJdQauulY5MirTefr5aMJsNZkc0cysxFchH463HGlX8qzss+qXQrJqUSVVxYUdoZQ64Zbdi13J4dsXvUsXTPoi+998nTvprAi6F93W4rxbID3u/A85IJEjo4vbyb+bOvlDAmtixmovaS0ktczPY2cpLmuEftEZUfkM+rgy9qNallSvne4bsW8VL0XPRbuIPIYJzGxOjedmbTQy5aYApb3isdLXijjeTIYVi67Vzb+5l5T4pn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(2906002)(66476007)(38100700002)(122000001)(5660300002)(66556008)(54906003)(38070700005)(66446008)(8936002)(64756008)(76116006)(4326008)(66946007)(41300700001)(8676002)(1076003)(316002)(36756003)(83380400001)(2616005)(6506007)(6512007)(26005)(186003)(478600001)(71200400001)(86362001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDlocm9ESFJ1RkF2KytaVmhnK01yMlJOeEZBZ2RXc0MzS25aNndMd2JUbnV6?=
 =?utf-8?B?cDJ3Zis1amtWZk5JSVJMQnVpY1R1dDFCUHpQSVdTOEtrQUlmRTl5ZkxPSlRZ?=
 =?utf-8?B?MVVncHJiVlFHTDJmRUxyNldtdFNzRlhwRWgzRzJVeDl0bEtpWVFVdGZ6MDJz?=
 =?utf-8?B?dGJMNGN4L1hDSldVVVNmWHZkbmh5bDJxTDh0cTVZY3RDc203WnFBaTdVdm1n?=
 =?utf-8?B?bmZzVHZnMnM5d1VKMGVDRE9hRkErVUdML3dXWHhZSTQ4aVdnWVlwTmNvSW5o?=
 =?utf-8?B?MllFNEY5Uk8wNVdiODJ0ZER4c1ZJUEs0NlhQVkZhVU95TUI3bm9kQ1FHUW5F?=
 =?utf-8?B?WjhjKzdQM2plUW1wUG1sa2VnSkpTcnc5STltaHh4NkpKNXJUeWFhTjdaVU1t?=
 =?utf-8?B?SldEMWIwUWMwdndqcTJQbTkwUSt2WlVvS09vQi9TZWZpajIxalBDd3h6WkJL?=
 =?utf-8?B?Y3FwblNGOVd0ODM5R05UYkJ5T0dVK1h0amRMU0F1MEV6Ly9qT3U5UjZnTkYz?=
 =?utf-8?B?S3RuUFVvU0J4QTJDNGhLOEpudjF6YlJTUCtQSG0zVXhRcGZCUFVwRjZkQW9K?=
 =?utf-8?B?ODlnR2M3TDFqOHJXMnlNc2pMNHB6VDM0VDZBREVKcnNKdjArWFUwVUM3WU1S?=
 =?utf-8?B?ZXgzd3doMEpubmhncjgyOS8xbjZDbEhGYkMvVHJmNzRsemwrQ0pwM0pDU3VI?=
 =?utf-8?B?bDhraTNQN1dMeEpEQVJNV0NwMFczM3hYRXNiNlRRSEVxWVVYVzNoUm8xSXZL?=
 =?utf-8?B?a0FDNTN6NC9hV0dEcUl5Q2NlUUxFMXZWQnpzTnVaT2VpK2FDMWttL0dXeEpM?=
 =?utf-8?B?a2MvS2lmYjVRQ1U2dHRYMzJIbVFoTmRNVC9HNmFaMC9NeExsU1habGo3Q2Iz?=
 =?utf-8?B?dDNCMitxZDZWL05RUjNwZkg0dmd1ZmRvU08wQVVyY0J0eTZEWUJnOGIyd2Q0?=
 =?utf-8?B?SUFUeDdNS0xjZUo5SE51YW04S0NQd3Iyb05VczJ1YXRaRkVwYVdlQ1lMT3Rj?=
 =?utf-8?B?N3ZtTm1IWmhwNTNkRHFSdS8xWEVZc0FPdE1VbGJvcDJERS9xYi9DYXdsYlI0?=
 =?utf-8?B?K1ZFUVZ4amNQbnR4NUVzV3pRUllYamVqV05VWVdyMnlxWHRRc25rRCtWNG1O?=
 =?utf-8?B?UXB2dlRxbFU2UTZmaFUrTFEzY3JBM0dldkZ4VmdtaGJHS1FqQ2tLSlozR3FK?=
 =?utf-8?B?cmdMTk9oWGdDOEpwakJKdWp6clRldEdBWUZZdXc1RElISjNXSmdOS24yMnZs?=
 =?utf-8?B?QkMwdnhEV1RxNm9KSFBsd050Z0pjT2dYYkkvWHBmODhLa1Q1V1NQNlJobGRw?=
 =?utf-8?B?Q2R1R1I3cHJOVTB1eUpYV2ZCWkpWNzBtNC9Yd0lNWlhqaTJ1OXVhSGVSYXc3?=
 =?utf-8?B?dGMwTnVTNjdSTlFGdWlTWXVEeGNXb1IxSURXbFVnMWN1eUllcUV2UzA2eG41?=
 =?utf-8?B?d2JMTDNxa0lURlJHK2tsK25PWVJiUXNyS1FaVFc0RzVBemhCQkx5cjNzSndm?=
 =?utf-8?B?eUllVGg5NUk5bW5Bc0N2VEJXOEkybHY2MVJqQzBhTHZJTnZwVjRaWmhYOGFQ?=
 =?utf-8?B?clZqd0cvemR0T0pNZ0Y2UVpIQVVNeHkvMGZlSkZoeXZJa0lFWGVTK2hiMVhk?=
 =?utf-8?B?MVRWMEVIU3pvNmdoV1AzeTd1OGRtWitlM0dQcEp2WmRRMEdyVmk5K0E1eHRW?=
 =?utf-8?B?cDBPTmdHSm9rc1BWSlBKSmcwUFFFeEpyMnJQcFRySExDSjRKSmdrdEJ5bFNQ?=
 =?utf-8?B?ZllPWlJ1V3FMbm80bmlYanZEQkZXRzI1VjdQaW1kNFplSENxQlVudlhvbVFp?=
 =?utf-8?B?d0h5bEpnOVEzYmRSejJZUnVrS29vcFVZZW44RVpnakxzM00vcmRtQTlNOGpP?=
 =?utf-8?B?V29uOHYxTjZ3MVl3WTd2MVVTa2t5eXpwSzZ4WVRJQWhoaWJ1aFdVR2lJZGtW?=
 =?utf-8?B?ODZPbjAyK04vOHJ4S3hFMk1ZOGpXcFRIL2NxRGNSczJGeGlSY0Y4WGJST2xV?=
 =?utf-8?B?NHBVT2FxVHZLQlpPU0tzSmdNbUhXakVFNTJPOFlvVXhMVDZoN1IydUNuV2tN?=
 =?utf-8?B?K1pTUzlaSENkbG1iWGFBSHE5SjlhTzg0Nm5BUWVkdjBLZ2d6dGk0czhRd2xz?=
 =?utf-8?Q?vNdKWSxkoXmtLsjEpC6umDjvP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CDCA7F14684B24689E18287662AA460@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rBeCsLs+rNC79rCzizjG+gSMQ4p+T3N1nEO+UIIPox0GydRlscJ5y49911+c+smjoUW1AsNKhLxpG20gt9169ynTPwqIBCDSpOqUVZj9aYniejwaHUAXZBf5wmm6OgpN+iMoNNJ+5JCxkKAkIbBfWQCOk8BdqIaxqdo+9iNHeQNx7kUWvsLIcdnkBt+LEOuHpKG9LaOG3xg2crxfXJQvdPGSYTanHkKTNc90kkxO7/My9kYGjIrr+zGzWww12zvAemdQYPVq72ZnVer6gYXT2ggz7p3zK8FpOIE9jwMBE1BtKKt/sVZ3tlNxgkYkW+RXH3sA9kesjughSWID2YRw3kP79KqJKqUJhouJvgRzyuLigOmYL71FQ1z3PXQrfjZdlhTvhZolf59/UdzCpdO5ngcJ8P9dHJEagGxsUx9TqQqCLGBXGnlW28hK1AV3kHzryGWKhuXntZWCB3mYHLvTwNRyiQ7gvEFU1pPe5T6BRj753vg3vhzXmk+wUPvTjYzRaNa/opOkKwhPC4f6J6SLlysCFjph6hjxjmvlh9YD9bu/zyhgXtdmGf0KQ8aPUowcw6x/2/VSqz9+yg4oAsnZm7NtH3SsBsk3sMBhONixA3QZ614X8PGb+aGeeJsDCbNTyxq/Z8M5ImWzDYUOZAaLzX3eg5SvyaVILb7uEWaLmmr/t1tyrxLxVBTqpA0YUhb36SrbZNTFn5yOOP9nSnF2Spz21s1oOa8aZ0Jsux/UNUKd8Z8I+H352oA8/sPeLuQ5qmPSrfXR+z6zHy4rvNBdYtiWWvnYFkdcinhWYts37RF7tjg6c/sZEvEFZd6yYldlwWl6ojtdhlkVmRhqxe2tfuIVGxk76Zw4Hf0tL1w4z7Dg1t6b079h+yTTBhFSJdJP
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bc2c4a-ddfd-4a8a-297e-08db3702eaf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 00:56:27.3589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6XWTCfa/MRLXDcvkS+yCFsj5ixTNQMJSd5FxEs5R0bVT+C5G2n2lTz8bkvO+LTNgkastnPTX4ChoJNjg7OQfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
X-Proofpoint-ORIG-GUID: nU-l6b46x2jG_a-4I44524AM-IcZffxJ
X-Proofpoint-GUID: nU-l6b46x2jG_a-4I44524AM-IcZffxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070006
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gQ2xlYW4gdXAgdGhl
IGNvcmUgaW5pdCBlcnJvciBoYW5kbGluZyBieSB1c2luZyBkZXNjcmlwdGl2ZSBuYW1lcyBmb3Ig
dGhlDQo+IGVycm9yIGxhYmVscyBhbmQgcmVsZWFzaW5nIHJlc291cmNpbmcgaW4gcmV2ZXJzZSBv
cmRlciBjb25zaXN0ZW50bHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbiBIb3ZvbGQgPGpv
aGFuK2xpbmFyb0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5j
IHwgMzAgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCAx
NTQwNWYxZjdhZWYuLmM0OTllZjAyNjUwMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTEwMDgsNyAr
MTAwOCw3IEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4g
IA0KPiAgCXJldCA9IGR3YzNfcGh5X3NldHVwKGR3Yyk7DQo+ICAJaWYgKHJldCkNCj4gLQkJZ290
byBlcnIwOw0KPiArCQlyZXR1cm4gcmV0Ow0KPiAgDQo+ICAJaWYgKCFkd2MtPnVscGlfcmVhZHkp
IHsNCj4gIAkJcmV0ID0gZHdjM19jb3JlX3VscGlfaW5pdChkd2MpOw0KPiBAQCAtMTAxNyw3ICsx
MDE3LDcgQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAg
CQkJCWR3YzNfY29yZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+ICAJCQkJcmV0ID0gLUVQUk9CRV9ERUZF
UjsNCj4gIAkJCX0NCj4gLQkJCWdvdG8gZXJyMDsNCj4gKwkJCXJldHVybiByZXQ7DQo+ICAJCX0N
Cj4gIAkJZHdjLT51bHBpX3JlYWR5ID0gdHJ1ZTsNCj4gIAl9DQo+IEBAIC0xMDI1LDcgKzEwMjUs
NyBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJaWYg
KCFkd2MtPnBoeXNfcmVhZHkpIHsNCj4gIAkJcmV0ID0gZHdjM19jb3JlX2dldF9waHkoZHdjKTsN
Cj4gIAkJaWYgKHJldCkNCj4gLQkJCWdvdG8gZXJyMGE7DQo+ICsJCQlnb3RvIGVycl9leGl0X3Vs
cGk7DQo+ICAJCWR3Yy0+cGh5c19yZWFkeSA9IHRydWU7DQo+ICAJfQ0KPiAgDQo+IEBAIC0xMDQy
LDcgKzEwNDIsNyBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2Mp
DQo+ICANCj4gIAlyZXQgPSBkd2MzX2NvcmVfc29mdF9yZXNldChkd2MpOw0KPiAgCWlmIChyZXQp
DQo+IC0JCWdvdG8gZXJyMTsNCj4gKwkJZ290byBlcnJfZXhpdF91c2IzX3BoeTsNCj4gIA0KPiAg
CWlmIChod19tb2RlID09IERXQzNfR0hXUEFSQU1TMF9NT0RFX0RSRCAmJg0KPiAgCSAgICAhRFdD
M19WRVJfSVNfV0lUSElOKERXQzMsIEFOWSwgMTk0QSkpIHsNCj4gQEAgLTEwNzcsMTYgKzEwNzcs
MTYgQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXVz
Yl9waHlfc2V0X3N1c3BlbmQoZHdjLT51c2IzX3BoeSwgMCk7DQo+ICAJcmV0ID0gcGh5X3Bvd2Vy
X29uKGR3Yy0+dXNiMl9nZW5lcmljX3BoeSk7DQo+ICAJaWYgKHJldCA8IDApDQo+IC0JCWdvdG8g
ZXJyMjsNCj4gKwkJZ290byBlcnJfc3VzcGVuZF91c2IzX3BoeTsNCj4gIA0KPiAgCXJldCA9IHBo
eV9wb3dlcl9vbihkd2MtPnVzYjNfZ2VuZXJpY19waHkpOw0KPiAgCWlmIChyZXQgPCAwKQ0KPiAt
CQlnb3RvIGVycjM7DQo+ICsJCWdvdG8gZXJyX3Bvd2VyX29mZl91c2IyX3BoeTsNCj4gIA0KPiAg
CXJldCA9IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChkd2MpOw0KPiAgCWlmIChyZXQpIHsNCj4g
IAkJZGV2X2Vycihkd2MtPmRldiwgImZhaWxlZCB0byBzZXR1cCBldmVudCBidWZmZXJzXG4iKTsN
Cj4gLQkJZ290byBlcnI0Ow0KPiArCQlnb3RvIGVycl9wb3dlcl9vZmZfdXNiM19waHk7DQo+ICAJ
fQ0KPiAgDQo+ICAJLyoNCj4gQEAgLTEyMDMsMjcgKzEyMDMsMjMgQEAgc3RhdGljIGludCBkd2Mz
X2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+ICANCj4g
LWVycjQ6DQo+ICtlcnJfcG93ZXJfb2ZmX3VzYjNfcGh5Og0KPiAgCXBoeV9wb3dlcl9vZmYoZHdj
LT51c2IzX2dlbmVyaWNfcGh5KTsNCj4gLQ0KPiAtZXJyMzoNCj4gK2Vycl9wb3dlcl9vZmZfdXNi
Ml9waHk6DQo+ICAJcGh5X3Bvd2VyX29mZihkd2MtPnVzYjJfZ2VuZXJpY19waHkpOw0KPiAtDQo+
IC1lcnIyOg0KPiAtCXVzYl9waHlfc2V0X3N1c3BlbmQoZHdjLT51c2IyX3BoeSwgMSk7DQo+ICtl
cnJfc3VzcGVuZF91c2IzX3BoeToNCj4gIAl1c2JfcGh5X3NldF9zdXNwZW5kKGR3Yy0+dXNiM19w
aHksIDEpOw0KPiAtDQo+IC1lcnIxOg0KPiArCXVzYl9waHlfc2V0X3N1c3BlbmQoZHdjLT51c2Iy
X3BoeSwgMSk7DQo+ICtlcnJfZXhpdF91c2IzX3BoeToNCj4gIAlwaHlfZXhpdChkd2MtPnVzYjNf
Z2VuZXJpY19waHkpOw0KPiAgZXJyX2V4aXRfdXNiMl9waHk6DQo+ICAJcGh5X2V4aXQoZHdjLT51
c2IyX2dlbmVyaWNfcGh5KTsNCj4gIGVycl9zaHV0ZG93bl91c2IzX3BoeToNCj4gIAl1c2JfcGh5
X3NodXRkb3duKGR3Yy0+dXNiM19waHkpOw0KPiAgCXVzYl9waHlfc2h1dGRvd24oZHdjLT51c2Iy
X3BoeSk7DQo+IC1lcnIwYToNCj4gK2Vycl9leGl0X3VscGk6DQo+ICAJZHdjM191bHBpX2V4aXQo
ZHdjKTsNCj4gIA0KPiAtZXJyMDoNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+IC0tIA0K
PiAyLjM5LjINCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5v
cHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
