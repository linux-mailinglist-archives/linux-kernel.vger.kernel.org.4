Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1C6B11DC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCHTQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCHTQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:16:30 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAFD5F6F0;
        Wed,  8 Mar 2023 11:16:28 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328J4q8t001016;
        Wed, 8 Mar 2023 11:15:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=3bGqwqZZOoOZo49Tji1EKmnTQAO3Ly/OFD8cPJm66RE=;
 b=m7ebc50QTVjFUkoZLWNoEPt+6Zzu/yFguhqf2FypfOcj8Lkev3kXtzY6XXvdCp1KL7O+
 F4cd0Li1IBVjVnluAB8jV1jKQa3uyXnheCYk06g2Skc1cPO3oQCiC/yW8+wF5tAglsdm
 VAr3MJIYETwl75U8XSBGeqPmyqgpzu+NSj5a0hOCWAh93a6DS85OffUpyUTgRzxeQn0W
 eNVqYzGqeS+bxritkRNC9+EqnThFThkk0sNCW9FpThauf6Dvn8sghjnEws4Qj292+iNh
 xckdV5enas9Vu9W1LOOkT1ELAc42ye9RW5wVaxfH8DVUB6Q3QuhYu7VjSM4OIBCeMt0G Vw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3p6tgru373-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 11:15:47 -0800
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BAF85C05AF;
        Wed,  8 Mar 2023 19:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678302947; bh=3bGqwqZZOoOZo49Tji1EKmnTQAO3Ly/OFD8cPJm66RE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=R56EcTG6wDAaFy3ZobmCInt/ekucI4nRdjjpfmOVkDR0O3iBi5G0t6f9anxs2MPGn
         DIxq/HJNDco1mgh8BELRT9iINKZReFHDhxxnbhMJdA9e0oSLRO1XEaZ6R/9o7ew/+l
         u6GAraW42OhQt6KPFxqc5WTAH60g5GCtmvRMA9qGE/u4cBnCJI9He1B+cDx3uTQyYD
         nZ0/zhJDLEOSRtJ9YbPER1SIZ8zMuPIQjLS1AGx4oS4sX53UxSi0Zukb8NgELufTbv
         4ozOcG1aGm7/O2rGchJR8qhz6kGfWW9MPggb/YU9LJ2bsZI3VZM1l6N9JQMCNI2z8S
         Jzclwez8lnzwg==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D142BA0080;
        Wed,  8 Mar 2023 19:15:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 22FB240079;
        Wed,  8 Mar 2023 19:15:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="RwY/dQRp";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLJ+bqyXOoSeY0dj6UbAPbtjdKfd43qBVSttRbZDWLswEw0RL9L62S2fwExNGDBTooviSyQgcwpAm4Jj3ewJ92sjsGQLC7DadmuzQLPcALD3vm1gg1mSQn2KCc1Em3TukV6Xz4MI5xVGEbX3YDcm5t8m96Rr9UwMlDO1cAMniAaWUz/E1gffQEriDlJ4LLS+aF2An67LtJHeABNt6/iO/1rHsrdmfMZzmA/2ip4LE0KI58RwOymuCo+qOAwsa7IsN4WYqmxa/+tejgLq5+/FgwRkymPcBR+puKSb8GFB1suQ0ouo4D3KZD6TQaEDoE6RMSkdlrjtAVRIZLrmZ9HbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bGqwqZZOoOZo49Tji1EKmnTQAO3Ly/OFD8cPJm66RE=;
 b=dWzwBP0MjpRdgesS8gX9GMOzFHQrxNGHr1N5L6dHEU/a2jlKv/k//pdq8lCBd5tT49gY/jTt38N+OmLLt/OLqO1mmx1VKmei03RvmuUz0Ki0X12FCWVPLj7IVwAApOXHZbg0lcviQG5f/EBGoGZKRtCYMcTzyVJEmlOBh3vWC7ngkNlBrz+DY7JBSXaj7WWpxHrwiFLspjbBGRHTWjk/WCna0cNZIzFdX0WjvbsvQqqw4/Aop8/AbgNHFgbkHhpUUd2LurQGqsxWDuYkP9CPic+R3tdDJHQcv2cPnXG8dwIE1H7+NjhCvLY2OGcmoQJvBwJmOXpMALPvBAAYxvf2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bGqwqZZOoOZo49Tji1EKmnTQAO3Ly/OFD8cPJm66RE=;
 b=RwY/dQRpTLoW3k3dqkOqIklBAymANj96OKGtVGpVM0vt0HiZJRDVJvaPZj5iCn5qoo1Ftib19q5zRWtba+36UoCEtb9I9mxR/W/MuFioWHfqHiBPvlSP2LAqY9kdSNJmjoXFFiK/q10sJSVZH+cwVjWbEFOdBdrQyn7/8kf66Xg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 19:15:40 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 19:15:40 +0000
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
Subject: Re: [PATCH v6 3/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH v6 3/5] usb: gadget: Add function wakeup support
Thread-Index: AQHZUFoVEkL2iNwZpkSvI1T+SaSq6q7xRAIA
Date:   Wed, 8 Mar 2023 19:15:39 +0000
Message-ID: <20230308191534.sjxxojditzirhgii@synopsys.com>
References: <1678127568-10609-1-git-send-email-quic_eserrao@quicinc.com>
 <1678127568-10609-4-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1678127568-10609-4-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH2PR12MB5001:EE_
x-ms-office365-filtering-correlation-id: be1ba2f4-c527-43f4-e843-08db2009813d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nt6d3yiI4ndHUv0PWX0KYqV4Rc8fEJVGVIeddc37yOvj5MWL6zl3Wv5yI4CxX0ABYwNtH5tbPhAn+LLC18nhCCXq8srVFrTc2/RhPQepASIhBLcukEs7yMXFhYZsWdm7g7DWu45Z++uOQufC92PnhVzweSux68GBQbrnrImmcP7OSnc/rJHtsKq4xw8EohC4KKfDrfHY2CAbLFQ5zBjJk8p99BtmCuV3XNQbQEfXIwLaRsTF/iu539np3QYWld6SDG71fKJ9eCIxHkeWd2rdPOVDndTdEMew49htz7XkzEe3JqoXzrTAcTlK+pRpZ6JWEvjodtuWa43850bIfx0LdGh5Ep7P6/hgynAg0NCUyKeMYLdGerLCbVm/xgc3tNgJ6PpoJMY+hqOqLfAKZra2TNnIzsewW0Pj0/vGjO6BjqRMcXm/KEigcXnlW6ElyslVuiTvLmgOm6uvmGoQvDogoKlKTYlBRNfJ+XQtoUWQXMvGQU3MIp/rrq1QReNMkAY+5VvU1hFvbgvi2hDyo9jSMh1amyt3cRuK/74XlepRhZiupOUEFWoXbEaSnMaGGtNG1790N1JlF84b7WlE4QmTGuL/F3PqQNJ/9/8obaYn5aaS4ffSVlJeCUyMWesh1XtbtYbM3RNoGab19wrtO09weRVcJIok4pbqNdjQBml7VjQK55rfgMc5Ck8ZQY6M4OnFyFAAF2xUCC4ayUfxegLmmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199018)(5660300002)(186003)(66476007)(71200400001)(38100700002)(76116006)(66946007)(64756008)(8676002)(66556008)(6916009)(66446008)(4326008)(478600001)(6486002)(54906003)(316002)(38070700005)(86362001)(41300700001)(6506007)(8936002)(1076003)(122000001)(6512007)(26005)(36756003)(2906002)(3716004)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWNxTWRXMTAvUGxJNFdxWWdHQWl5TWlmZmRGSUhYNkJqNy9Wc0NvWjlqb1JN?=
 =?utf-8?B?eTh4TEt6RTgrakNHL0FHQ3cwZUZIK2VpSDB0bnFoOUdPSUczQVdVWkZRckhI?=
 =?utf-8?B?dURmZXpENWEweE1VMUNaWUVqZ3VVejkrbC9kODI1QXMySlV2b0o3Zzg1RmZR?=
 =?utf-8?B?TndkZWtESW41blA5SVREeFFiYWlDREFNT1YzeWpXcXRyMWs2MVBBcjdqOVBB?=
 =?utf-8?B?UXQ5ZlBPVGZLVXRxSjVJVVlJM1NPUDl0UEluVGEwQ2NYYmZJekZrdWQyeWN1?=
 =?utf-8?B?S3JSNnU3eDg4RkxIb214cE5WNVVYZVhPQUxMQ1hUaUk5Y2MzdjJra2t0V1Fj?=
 =?utf-8?B?bS9YV2ZrMFpxWUIrb0F2QnRVYjlBS3A4U1dicjlZZm9lak1pSG9jcUtMeHR3?=
 =?utf-8?B?QWxMaEk4ampUN250SVBpMURhekJPMlBMSFUyMWxaeERhV0VkS0NORDVRVzVQ?=
 =?utf-8?B?STZtY1Brc0ZxckhycEh4OHpKWUdHTDRWNWZVS2lWRWtma0t6VkE2ZEdBeFc4?=
 =?utf-8?B?bmNUNlY5aThzZnVnVWxYK0JBVmZNMHNycjdaUGM5VnUxSHlUcTBYYUZRMnRZ?=
 =?utf-8?B?Yk54bE1DV0hpSitmczgwSGZxTG92dVYrdDNoWkk5QlZudktWRG4vU0Z1cUJu?=
 =?utf-8?B?RHU3SGEyZ3pyNUtHYTNHTzFOOHpDdnM1VFVuSElUZE9SOHVXeEdFeThJN0hi?=
 =?utf-8?B?c0VXRGdEZVJXQnRXUzY3cjQzR2tNZ0UzbUptRUtWZmpodjdHL3VVbXNXVExC?=
 =?utf-8?B?YllHcG83K09TcE1IK2VJanIva2lNZ2YwWWVzZDNEZWk4OWhRdktiMFViN0ox?=
 =?utf-8?B?aVlZVVdRTVY0clAveEdRNkdTS0pCbzRqK2V6b04reWEvcksrK29lVzYvYy9T?=
 =?utf-8?B?b0hkMlBCRDJpNWVKZnpBWlZ6M29mNURvVXRuZUpuTTdqS1IySng4ZVdLM2NN?=
 =?utf-8?B?dy9CWDRpZmtQYVlXRWxWWHgrWGpDeHBNcUxQUnFubkowU0o4bG9GK2xyUjg4?=
 =?utf-8?B?K3NOVEtXUytoU0N4Tm41SWlOaEYxRllzTVVrV3FOWEIyNHlQSW0zSU8xLzZv?=
 =?utf-8?B?d214SDd1UHlWZ0Qzek9NSXVpVlNyR21DeWNzQnN4aExOa1U4bDgvMzQzZ25r?=
 =?utf-8?B?NzBGZUxaQTBvYVpENjlYbzcwMHRQYnVDMTBkRDA4c1pIa2dvRTczb2c0K1pq?=
 =?utf-8?B?ZEtWb2ZBcytqZU1hUzJEUmZTSnhEZ212dVl3Vk5JU09GMjFJRU15d0lURkJv?=
 =?utf-8?B?NWxTalJ6UlpmMHlvRDR3TTlPbGZyVEppT2tnVDRIS2NIeVhkb2U3TGJkZVh0?=
 =?utf-8?B?azFaNFh4MGZ0NFpSOFhwdzh3VUpLM29MeEdmUzRuckRFcDgxV0l5K2pqb296?=
 =?utf-8?B?WjBpQnp5SVZjaTJtcjZyUlZCYS9BZVpPS1FaRVFsNU5mcU96czBzcURWT2RP?=
 =?utf-8?B?cXVlRytTaXhEdTRzZHczR0tMd0FSMlFzdi9DdWdCV1EyV0Y0VzRnaHN1VFNo?=
 =?utf-8?B?a1NqS2piWU5RaXVjTUNxUDVqYlcyZXhXUXg1ZDZ1dk42UEtPbit6d1pxL2Qy?=
 =?utf-8?B?RjJGeUxlM1NYTXNFd2c5UVVTM3pKdXh6bGNiRzlyMzQ1YlAwdWtOUUhOKzR0?=
 =?utf-8?B?WG1HMEJ3Q0lMNzhoVnphdmRGRFVMUm9YV1d5K2lvZmdaRTdFYkovUkpwSjhE?=
 =?utf-8?B?TWVlVlpUVkNwL0Jwc1gyOG82dTk5dWoxRUJwRXk3T1RaRjhNcFVPUm93Tys1?=
 =?utf-8?B?TWRpVG1sbTRTU0hjbWlPMzQyTG5laE5UV2FEeTE1QXV5anQrUUEzUjVzcm5x?=
 =?utf-8?B?Q0J5UGduL1h3LzdFWE1ndktlb1pUMllZbVdjQ2Myd1JwcXo4L2JUdk9PYndV?=
 =?utf-8?B?VG1rSUZuKzZ4anE0cTR5aDRHL3BTTVY5ZnpIMVlNMUZrMWFYb29VMUZMc0Fs?=
 =?utf-8?B?NnFpUGRwcm5YcFB4MTVSWm51ZFlldmtBazVTTGtnN0djY2VDQmVqUWM5eG9o?=
 =?utf-8?B?cEIxYTR4ZlB6K0p6TDU2RUd0WXNPK0ZKdUFjdUQ2ZjNIY3BVQzJtRnpESkFh?=
 =?utf-8?B?ZjdiamY3cFBydmlGLzB1ODFEYmxHZGErKzJvWkhCWGlYKzQybG1HZENQTGd1?=
 =?utf-8?Q?mqr13Catw4dGZm1stCWfs/SOp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF2F80F124E5474AABE8F0B6396914C6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PFIyWHdD/nKGhf0kWE2QU6Kg8U0afugFOOB4OYWz3tLQFE64rynCSyENbaBA255n32qs0pZMUYT98sBEA7o9WDgZ20zJlOUlBEg9uGM/ZsUm7i5y4ibLWW+8V3tWLo2ORU/xyy/htCcSCWZlKOd86gD6v1KRrCPCXXwfS1SZFejDEHXT9e96pZ14QXzMhZBQ4AWg5W+ON0JP3OBRFcKDYLEnBCaZeCM+OhSLSzKInuK2ZOs3PkEpf5UDoeLH95+39axAVWhmrioMej6vessbE2auCazYwQ7z6Z7JzF5MhgZxBGsbD8KHUyYCfJLiTiriF4KfwRt+AKgA1GSerqWm9Xg46YM1yvBByN4Iqa7q4Ty1fFy1PuHN4ZiqxY+iemhqp1J5FZ8fqW6Teb86WjCOya/vm9nJq0yTw5kcNRf3IHPE+NpM22KjDhP1sI4HHRfpq1cVGklxGJvjKM+vBEr+IjlWl61/hOuSRaaRnO2u2vsILd+l1oCJb8fctQSJGySJArJnwpqYzeq8rJ/PDXau34/lmrx/bJteMl7d48FOFADuZHOpFOWYj6b5Bkg+J2TD5T/T6PG0pv9A7X83eLcPJ1MUi3cE8erkaV4TE3UhvyrdWT1WgkEJ5nX65gCTb1Axz+p6SFJKZQFpq/S2A7gjUBtrZqPrtNZXy3VxPfOXxPlBoVNzXNBpDIzsmF0oRD/beyTVoR2Dq5rU0zeTiTrWsioSnRSrRoyEe41QHVfdo20ln4VJdfW7K/XXe+QrmI1hsA/uhSlyWyu81k3jaJIdKPDE8ieaf2jv8pdn2KpJ5+PoKKXqKuBGih1BlN5SgnJRz13EmpGAo/HvM/fwxJ0Y/xbcxEBBOIf3KEU40Yr8GWt05yUTq54POgV/Q/LqAp4rHvj32AY4hK3lDOSwcJ2V4jQjtXzSEslIdFAcoiYURTI=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1ba2f4-c527-43f4-e843-08db2009813d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 19:15:39.8013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Us07vQ33OT8dvFwH3edB6cyRUXW8amsqUzL4jK+V2SxVoHMml8m8DYvJFqKKXQumXYc4d/iHmLC+6CUtK6NQhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
X-Proofpoint-ORIG-GUID: g1tUWZARfELbLxKdgI4MwBYz4Oq5XdUY
X-Proofpoint-GUID: g1tUWZARfELbLxKdgI4MwBYz4Oq5XdUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_12,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=376 bulkscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRWxzb24sDQoNCk9uIE1vbiwgTWFyIDA2LCAyMDIzLCBFbHNvbiBSb3kgU2VycmFvIHdyb3Rl
Og0KPiBBIGZ1bmN0aW9uIHdoaWNoIGlzIGluIGZ1bmN0aW9uIHN1c3BlbmQgc3RhdGUgaGFzIHRv
IHNlbmQgYQ0KPiBmdW5jdGlvbiB3YWtlIG5vdGlmaWNhdGlvbiB0byB0aGUgaG9zdCBpbiBjYXNl
IGl0IG5lZWRzIHRvDQoNClRoaXMgc2hvdWxkIGJlIHJlcGhyYXNlZC4gVGhlIGRldmljZSBkb2Vz
bid0IHNlbmQgd2FrZXVwIGRldmljZQ0Kbm90aWZpY2F0aW9uIHdoaWxlIGluIHN1c3BlbmQuDQoN
Cj4gZXhpdCBmcm9tIHRoaXMgc3RhdGUgYW5kIHJlc3VtZSBkYXRhIHRyYW5zZmVyLiBBZGQgc3Vw
cG9ydCB0bw0KPiBoYW5kbGUgc3VjaCByZXF1ZXN0cyBieSBleHBvc2luZyBhIG5ldyBnYWRnZXQg
b3AuDQoNClBsZWFzZSBwcm92aWRlIG1vcmUgaW5mbyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgZGVz
Y3JpYmluZyB0aGUgY2hhbmdlLg0KWW91IGRpZCBtb3JlIHRoYW4ganVzdCBhZGRpbmcgYSBuZXcg
Z2FkZ2V0IG9wIGhlcmUuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8g
PHF1aWNfZXNlcnJhb0BxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQv
Y29tcG9zaXRlLmMgfCA0MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICBpbmNsdWRlL2xpbnV4L3VzYi9jb21wb3NpdGUuaCAgfCAgNiArKysrKysNCj4gIGluY2x1
ZGUvbGludXgvdXNiL2dhZGdldC5oICAgICB8ICAxICsNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNDcg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb21w
b3NpdGUuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiBpbmRleCA3NTEyODU0
Li43YWU3OGMwNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5j
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiBAQCAtNDkyLDYgKzQ5
Miw0NiBAQCBpbnQgdXNiX2ludGVyZmFjZV9pZChzdHJ1Y3QgdXNiX2NvbmZpZ3VyYXRpb24gKmNv
bmZpZywNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKHVzYl9pbnRlcmZhY2VfaWQpOw0KPiAg
DQo+ICsvKioNCj4gKyAqIHVzYl9mdW5jX3dha2V1cCAtIHNlbmRzIGZ1bmN0aW9uIHdha2Ugbm90
aWZpY2F0aW9uIHRvIHRoZSBob3N0Lg0KPiArICogQGZ1bmM6IGZ1bmN0aW9uIHRoYXQgc2VuZHMg
dGhlIHJlbW90ZSB3YWtldXAgbm90aWZpY2F0aW9uLg0KPiArICoNCj4gKyAqIEFwcGxpY2FibGUg
b25seSB0byBlbmhhbmNlZCBzdXBlciBzcGVlZCBkZXZpY2VzIHdoZW4gdXNiIGZ1bmN0aW9ucw0K
DQpFbmhhbmNlZCBTdXBlclNwZWVkIGRldmljZXMgY2FuIG9wZXJhdGUgaW4gdXNiMiBzcGVlZHMu
IFRoaXMgc2hvdWxkIGJlDQpyZXBoYXNlZCB0byByZWZlciB0byB0aGUgb3BlcmF0aW5nIHNwZWVk
IGluc3RlYWQuDQoNCj4gKyAqIGFyZSBwdXQgaW4gZnVuY3Rpb24gc3VzcGVuZCBzdGF0ZSBhbmQg
YXJtZWQgZm9yIGZ1bmN0aW9uIHJlbW90ZSB3YWtldXAuDQo+ICsgKiBPbiBjb21wbGV0aW9uLCBm
dW5jdGlvbiB3YWtlIG5vdGlmaWNhdGlvbiBpcyBzZW50LiBJZiB0aGUgZGV2aWNlIGlzIGluDQo+
ICsgKiBsb3cgcG93ZXIgc3RhdGUgaXQgdHJpZXMgdG8gYnJpbmcgdGhlIGRldmljZSB0byBhY3Rp
dmUgc3RhdGUgYmVmb3JlDQo+ICsgKiBzZW5kaW5nIHRoZSB3YWtlIG5vdGlmaWNhdGlvbi4gU2lu
Y2UgaXQgaXMgYSBzeW5jaHJvbm91cyBjYWxsLCBjYWxsZXINCj4gKyAqIG11c3QgdGFrZSBjYXJl
IG9mIG5vdCBjYWxsaW5nIGl0IGluIGludGVycnVwdCBjb250ZXh0LiBGb3Igbm9uIGVuaGFuY2Vk
DQo+ICsgKiBzdXBlciBzcGVlZCBkZXZpY2VzIG9wZXJhdGluZyBpbiBsb3dlciBzcGVlZHMgcmV0
dXJucyBuZWdhdGl2ZSBlcnJuby4NCg0KU2FtZSBoZXJlLiBFbmhhbmNlZCBTdXBlclNwZWVkIGRl
dmljZXMgY2FuIG9wZXJhdGUgaW4gbG93ZXIgc3BlZWRzLg0KDQpJdCdzIGEgZ29vZCBpZGVhIHRo
YXQgeW91IGRpc2NhcmRlZCBjcmVhdGluZyB1c2JfZ2FkZ2V0X2Z1bmNfd2FrZXVwKCkuDQpJbiB1
c2JfZ2FkZ2V0X3dha2V1cCgpLCB3ZSBwbGFjZSB0aGUgYnVyZGVuIG9mIGNoZWNraW5nIHdoZXRo
ZXIgdGhlIGhvc3QNCmVuYWJsZWQgcmVtb3RlIHdha2V1cCBpbiB0aGUgVURDIGRyaXZlci4gRm9y
IHVzYl9mdW5jX3dha2V1cCgpLCB5b3UNCnBsYWNlIHRoZSBidXJkZW4gb2YgY2hlY2tpbmcgd2hl
dGhlciB0aGUgaG9zdCBlbmFibGVkIGZ1bmN0aW9uIHJlbW90ZQ0Kd2FrZXVwIGluIHRoZSBjb21w
b3NpdGUgbGF5ZXIuIElmIHdlIGhhdmUgdXNiX2dhZGdldF9mdW5jX3dha2V1cCgpLCB0aGVuDQp5
b3UgbWF5IG5lZWQgdG8gY2xhcmlmeSBob3cgdG8gaGFuZGxlIHRoYXQuDQoNCj4gKyAqDQo+ICsg
KiBSZXR1cm5zIHplcm8gb24gc3VjY2VzcywgZWxzZSBuZWdhdGl2ZSBlcnJuby4NCj4gKyAqLw0K
PiAraW50IHVzYl9mdW5jX3dha2V1cChzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmdW5jKQ0KPiArew0K
PiArCXN0cnVjdCB1c2JfZ2FkZ2V0CSpnYWRnZXQgPSBmdW5jLT5jb25maWctPmNkZXYtPmdhZGdl
dDsNCj4gKwlpbnQJCQlpZDsNCj4gKw0KPiArCWlmICghZnVuYy0+ZnVuY193YWtldXBfYXJtZWQp
IHsNCj4gKwkJRVJST1IoZnVuYy0+Y29uZmlnLT5jZGV2LCAibm90IGFybWVkIGZvciBmdW5jIHJl
bW90ZSB3YWtldXBcbiIpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwlp
ZiAoIWdhZGdldC0+b3BzLT5mdW5jX3dha2V1cCkNCj4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOw0K
DQpNYXliZSB0aGlzIGNoZWNrIHNob3VsZCBnbyBmaXJzdC4NCg0KPiArDQo+ICsJZm9yIChpZCA9
IDA7IGlkIDwgTUFYX0NPTkZJR19JTlRFUkZBQ0VTOyBpZCsrKQ0KPiArCQlpZiAoZnVuYy0+Y29u
ZmlnLT5pbnRlcmZhY2VbaWRdID09IGZ1bmMpDQo+ICsJCQlicmVhazsNCj4gKw0KPiArCWlmIChp
ZCA9PSBNQVhfQ09ORklHX0lOVEVSRkFDRVMpIHsNCj4gKwkJRVJST1IoZnVuYy0+Y29uZmlnLT5j
ZGV2LCAiSW52YWxpZCBmdW5jdGlvblxuIik7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0N
Cj4gKw0KPiArCXJldHVybiBnYWRnZXQtPm9wcy0+ZnVuY193YWtldXAoZ2FkZ2V0LCBpZCk7DQo+
ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh1c2JfZnVuY193YWtldXApOw0KPiArDQo+ICBzdGF0
aWMgdTggZW5jb2RlX2JNYXhQb3dlcihlbnVtIHVzYl9kZXZpY2Vfc3BlZWQgc3BlZWQsDQo+ICAJ
CXN0cnVjdCB1c2JfY29uZmlndXJhdGlvbiAqYykNCj4gIHsNCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvdXNiL2NvbXBvc2l0ZS5oIGIvaW5jbHVkZS9saW51eC91c2IvY29tcG9zaXRlLmgN
Cj4gaW5kZXggZDk0OWU5MS4uYTI0NDhlOSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC91
c2IvY29tcG9zaXRlLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC91c2IvY29tcG9zaXRlLmgNCj4g
QEAgLTE1MCw2ICsxNTAsOSBAQCBzdHJ1Y3QgdXNiX29zX2Rlc2NfdGFibGUgew0KPiAgICoJR2V0
U3RhdHVzKCkgcmVxdWVzdCB3aGVuIHRoZSByZWNpcGllbnQgaXMgSW50ZXJmYWNlLg0KPiAgICog
QGZ1bmNfc3VzcGVuZDogY2FsbGJhY2sgdG8gYmUgY2FsbGVkIHdoZW4NCj4gICAqCVNldEZlYXR1
cmUoRlVOQ1RJT05fU1VTUEVORCkgaXMgcmVzZWl2ZWQNCj4gKyAqIEBmdW5jX3N1c3BlbmRlZDog
SW5kaWNhdGVzIHdoZXRoZXIgdGhlIGZ1bmN0aW9uIGlzIGluIGZ1bmN0aW9uIHN1c3BlbmQgc3Rh
dGUuDQo+ICsgKiBAZnVuY193YWtldXBfYXJtZWQ6IEluZGljYXRlcyB3aGV0aGVyIHRoZSBmdW5j
dGlvbiBpcyBhcm1lZCBieSB0aGUgaG9zdCBmb3INCj4gKyAqCXdha2V1cCBzaWduYWxpbmcuDQo+
ICAgKg0KPiAgICogQSBzaW5nbGUgVVNCIGZ1bmN0aW9uIHVzZXMgb25lIG9yIG1vcmUgaW50ZXJm
YWNlcywgYW5kIHNob3VsZCBpbiBtb3N0DQo+ICAgKiBjYXNlcyBzdXBwb3J0IG9wZXJhdGlvbiBh
dCBib3RoIGZ1bGwgYW5kIGhpZ2ggc3BlZWRzLiAgRWFjaCBmdW5jdGlvbiBpcw0KPiBAQCAtMjIw
LDYgKzIyMyw4IEBAIHN0cnVjdCB1c2JfZnVuY3Rpb24gew0KPiAgCWludAkJCSgqZ2V0X3N0YXR1
cykoc3RydWN0IHVzYl9mdW5jdGlvbiAqKTsNCj4gIAlpbnQJCQkoKmZ1bmNfc3VzcGVuZCkoc3Ry
dWN0IHVzYl9mdW5jdGlvbiAqLA0KPiAgCQkJCQkJdTggc3VzcGVuZF9vcHQpOw0KPiArCWJvb2wJ
CQlmdW5jX3N1c3BlbmRlZDsNCj4gKwlib29sCQkJZnVuY193YWtldXBfYXJtZWQ7DQo+ICAJLyog
cHJpdmF0ZTogKi8NCj4gIAkvKiBpbnRlcm5hbHMgKi8NCj4gIAlzdHJ1Y3QgbGlzdF9oZWFkCQls
aXN0Ow0KPiBAQCAtMjQxLDYgKzI0Niw3IEBAIGludCBjb25maWdfZXBfYnlfc3BlZWRfYW5kX2Fs
dChzdHJ1Y3QgdXNiX2dhZGdldCAqZywgc3RydWN0IHVzYl9mdW5jdGlvbiAqZiwNCj4gIA0KPiAg
aW50IGNvbmZpZ19lcF9ieV9zcGVlZChzdHJ1Y3QgdXNiX2dhZGdldCAqZywgc3RydWN0IHVzYl9m
dW5jdGlvbiAqZiwNCj4gIAkJCXN0cnVjdCB1c2JfZXAgKl9lcCk7DQo+ICtpbnQgdXNiX2Z1bmNf
d2FrZXVwKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmZ1bmMpOw0KPiAgDQo+ICAjZGVmaW5lCU1BWF9D
T05GSUdfSU5URVJGQUNFUwkJMTYJLyogYXJiaXRyYXJ5OyBtYXggMjU1ICovDQo+ICANCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdXNiL2dhZGdldC5oIGIvaW5jbHVkZS9saW51eC91c2Iv
Z2FkZ2V0LmgNCj4gaW5kZXggMWQ3OTYxMi4uNzViZGEwNzggMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvbGludXgvdXNiL2dhZGdldC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvdXNiL2dhZGdldC5o
DQo+IEBAIC0zMTAsNiArMzEwLDcgQEAgc3RydWN0IHVzYl91ZGM7DQo+ICBzdHJ1Y3QgdXNiX2dh
ZGdldF9vcHMgew0KPiAgCWludAkoKmdldF9mcmFtZSkoc3RydWN0IHVzYl9nYWRnZXQgKik7DQo+
ICAJaW50CSgqd2FrZXVwKShzdHJ1Y3QgdXNiX2dhZGdldCAqKTsNCj4gKwlpbnQJKCpmdW5jX3dh
a2V1cCkoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCwgaW50IGludGZfaWQpOw0KPiAgCWludAko
KnNldF9yZW1vdGVfd2FrZXVwKShzdHJ1Y3QgdXNiX2dhZGdldCAqLCBpbnQgc2V0KTsNCj4gIAlp
bnQJKCpzZXRfc2VsZnBvd2VyZWQpIChzdHJ1Y3QgdXNiX2dhZGdldCAqLCBpbnQgaXNfc2VsZnBv
d2VyZWQpOw0KPiAgCWludAkoKnZidXNfc2Vzc2lvbikgKHN0cnVjdCB1c2JfZ2FkZ2V0ICosIGlu
dCBpc19hY3RpdmUpOw0KPiAtLSANCj4gMi43LjQNCj4gDQoNClRoYW5rcywNClRoaW5o
