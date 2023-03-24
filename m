Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB3B6C76D1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCXFIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXFIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:08:20 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00B228EA9;
        Thu, 23 Mar 2023 22:08:19 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NLv3qJ002668;
        Thu, 23 Mar 2023 22:08:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=TU3FD473FKgmfIa0PQ2Uizn5ra5SsUMSbSpzRlv12GU=;
 b=cKOrKjbU2G9dFOH45sp61UJWEZVSa74tggm56s+eoCO3H0nw2+h/9aJNltzwyvk/Po+Q
 CYZ+GVCQTiYmy6vOGMKIceTtYMdZV7A9GUF5nUuXKvdb2yISSokGvEcoyLTW0HxZZyhT
 2a/tfLuKwxLcqX84pSMWHEj4JDzy7Y7t0kynvBYBLVsZgdTIaK65JE4WZqtdS5Q/VJvK
 TJc+0POgCIRBnlQ4Yq6PyG2s3qv1nbAYI2IBq6okoNxKhfrjnAGSaGZ4REvcgeb8afQ8
 NhltCkdazRCKHJBnXG7PBsxIubWRh86vJR1fW/NiEYyKhimMDXtZ+Wcq7tzi+zYu+ZJO BA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pgxkcsptd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 22:08:06 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 18A9BC0445;
        Fri, 24 Mar 2023 05:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679634485; bh=4YzBxATIvLoej5eBElwhsR6kZhRXVJq/5IgW1dQ/0rk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bfi/64voHSMomAMUBp44S3Z3G9cQScUjp4/daxvtfEWoIQlctEn/VNcekb0K2seOp
         EZJMVvwYkfUIIrSzRvGGHvvBax+EqOv2e9QCQw+7Naxu1VwOrKKy6Ncdptzm6BNon9
         IPdV2Kgfdnn0pLnPz7qtefnZrcy/y+rFo5vTLT4u+ZazUD0efTbQUBMR4yDpFY6eD5
         /KXRh9w5TrAWluswoyTofYFgrOUyjzQZn3IlA+zqzJiX6e6H4zyDkkrZqn5OrJrqwN
         /Y5ohuGvNXAg0q88JJQM1+4+KPlMVccp7NUq3CS16R85fSN02OoNaR3m0PERWu9ZE3
         U7lARJi/cZUsg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id F0F34A006D;
        Fri, 24 Mar 2023 05:08:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E1A9180175;
        Fri, 24 Mar 2023 05:08:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="mzc4EUKL";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGsEoh49EHdzTm5PBhaOw5myNQPNtQ5QszH3C6r/OAOELWi9xEURQVUJmhXNeLqAykhUHws1E4bYbC+e9BzG87/+4wbsoyGKmwy6lxmV165Ato58P3hnCqzAQv+fkqXUx+ORX5EVp0mIB3bRUvJ8zJjpqUXDrrmhSSbrYnSOa8A5L7lwaq6ObvkckwV5GVuEM6xmhjzG+5+LOM8H4n0gWhAS2cAzPpJvx1J7d9gNDE2HUVk7VB9Ega18lcWKQysSdadcOQvEB/RocVB6EI3k2LYqlqXyZenzgEO4Ks7b8mJoblht4B4lvc+SzzbLhl5aKegmL1BKZXSZZ5DMigaq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TU3FD473FKgmfIa0PQ2Uizn5ra5SsUMSbSpzRlv12GU=;
 b=JEnIsl+NscY7Ir80y3ciDCOMiWMHJx0fGXgWXjIjtVSdiEZ6HWnZ3/ZC0P7xcyb19oYj4uj1xYQyurCw7n5JaKzo1WahqifXCth/bxX8CqSf7erVwmH4cwS2GP2AvtEZm1ms6ZkZByYIXo0+SFhkktiFu3UThKsSjxBxc8Ows24IKPRGep6wmN2qHFGXFj4+gvMw8LO4AkzyYPCovqGpmgJ4S6dWbzFZzo64UL/fIFPaySh8Ij6B1VZepRx4v2tNSrjin80hg61SJpNIrpDw5r+cObugYbN6B5XKqbqqhR61BKZZLfM4emZSkFH7v1aMuVI27w/zgfXu62U/ndowhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TU3FD473FKgmfIa0PQ2Uizn5ra5SsUMSbSpzRlv12GU=;
 b=mzc4EUKL9jarSpTXdlZtiOh2Zc9F6xT00QVStVe7gODcf2Z+wdb2KgVHqozZK9v1nSLbR2JfFlrOl6OEZa7serGjo4PMgQ3dmppWru2mbe2pLcByCazoQl6/dGh0kCywbwLiyeO78t4+2B6WL6M9nr9mGL7WSMD76Mwp0EECFLw=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 05:07:51 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::b864:207b:e50f:2ffe]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::b864:207b:e50f:2ffe%5]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 05:07:51 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "amelie.delaunay@foss.st.com" <amelie.delaunay@foss.st.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>
Subject: RE: [PATCH v2] usb: dwc2: fix a devres leak in hw_enable upon suspend
 resume
Thread-Topic: [PATCH v2] usb: dwc2: fix a devres leak in hw_enable upon
 suspend resume
Thread-Index: AQHZV+MsmbvIgrm46EGwKIDQHfFEzK8JbLfA
Date:   Fri, 24 Mar 2023 05:07:51 +0000
Message-ID: <BYAPR12MB33992472023C4D6BB4127B0CA7849@BYAPR12MB3399.namprd12.prod.outlook.com>
References: <20230316084127.126084-1-fabrice.gasnier@foss.st.com>
In-Reply-To: <20230316084127.126084-1-fabrice.gasnier@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaG1pbmFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZDBmYmJiMDEtY2EwMS0xMWVkLWIwNzItNWM1ZjY3?=
 =?us-ascii?Q?NjdkNDhiXGFtZS10ZXN0XGQwZmJiYjAzLWNhMDEtMTFlZC1iMDcyLTVjNWY2?=
 =?us-ascii?Q?NzY3ZDQ4YmJvZHkudHh0IiBzej0iNDQzMCIgdD0iMTMzMjQxMDgwNjc4NjAy?=
 =?us-ascii?Q?MjcwIiBoPSJmM0lUaWRoWXpOallta0lLNUpkbG81aWRzVHM9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIWUlBQUFl?=
 =?us-ascii?Q?VmxhVERsN1pBWUJpa0ZxNUwrQzlnR0tRV3JrdjRMME5BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFBR0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQTJXMC9vZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCdEFH?=
 =?us-ascii?Q?a0FZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lB?=
 =?us-ascii?Q?YndCMUFHNEFaQUJ5QUhrQVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpB?=
 =?us-ascii?Q?SFFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFl?=
 =?us-ascii?Q?UUJmQUhBQVlRQnlBSFFBYmdCbEFISUFjd0JmQUhRQWN3QnRBR01BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJtQUc4QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRB?=
 =?us-ascii?Q?QnVBR1VBY2dCekFGOEFkUUJ0QUdNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?Y0FkQUJ6QUY4QWNBQnlBRzhBWkFCMUFHTUFkQUJmQUhRQWNnQmhBR2tBYmdC?=
 =?us-ascii?Q?cEFHNEFad0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCaEFHd0FaUUJ6QUY4?=
 =?us-ascii?Q?QVlRQmpBR01BYndCMUFHNEFkQUJmQUhBQWJBQmhBRzRBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpBR0VBYkFCbEFI?=
 =?us-ascii?Q?TUFYd0J4QUhVQWJ3QjBBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUhNQWJnQndBSE1BWHdCc0FHa0FZd0JsQUc0?=
 =?us-ascii?Q?QWN3QmxBRjhBZEFCbEFISUFiUUJmQURFQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdVQVh3QjBBR1VB?=
 =?us-ascii?Q?Y2dCdEFGOEFjd0IwQUhVQVpBQmxBRzRBZEFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCMkFHY0FYd0Jy?=
 =?us-ascii?Q?QUdVQWVRQjNBRzhBY2dCa0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|SA1PR12MB6946:EE_
x-ms-office365-filtering-correlation-id: c689d963-1491-4714-1154-08db2c25b7dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K9eDA7Sh4LIqyxkbblUn7szYCLziRXj5dHr2OPKcR9r/J3+4/aETqlpgUKkC/6rSKG9oaE3erDf6T4L3pZBadFfJazlYsdbYsYl5f+2SFob3V62Bmx8oG6yvNLci/VkeLxFp+Q0zs/xyYHi4UBjDwZxzqHc2ifMJ1eLQgKgcvZFeKXmHQVr+3P4pck5LnDDguG2vdG1EzefpWdBx2kcNgTn9fErL7Y9TmBVld+JE7uy9Vl0OUhJxJWarkgFLKOqckM+UAEjxHFuW/12emh9+qostRLHdnuMfAA0TJALEhV3VFk+KwXWNwj4GcQCGyJAsGdD1cK6s0K8VHzWbhXevbLXnyQFJWBsQkYGgQx2X0P8c1MwH00pj+F0sSurbFId6R/2iJX2TZfpdR0druy6Wz4PHHQla5up8yYDUr2X43WKjT09dDhefjxWdJqZ2vDPVn9a/QLnWGC8IQ2DakT3WAuikKqM2F5OdbFuk1TwZTPnvr6N4JDRmG7PCAO9jlM8ocyBHLPLc+7uahBeRZ1ASymk7rH/6nh/bE2r8Y+4vVoX/Txx5bJA8gTgEJ1lEtryRbrwMTeeFRia0FxIk/NfO2e61KKyaWH96KZIc1LY42bKobyPULYoD1O22oAqAJYzpiBzrniutBzg39jAqXZHg+1vgjyme9rzK+/jsQGXl/HweD8wUPWI7mSg45an+tNms+l6h2HTOF74OCkkpLO010g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199018)(64756008)(4326008)(8676002)(76116006)(66946007)(66476007)(66556008)(66446008)(52536014)(8936002)(33656002)(41300700001)(38100700002)(122000001)(186003)(83380400001)(71200400001)(55016003)(86362001)(38070700005)(6506007)(9686003)(26005)(110136005)(54906003)(7696005)(478600001)(316002)(15650500001)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ouL+wI1k2+0IbePfwixP1SDbKTF/fqbV6DigpLtf3J2+oRBI+7DxsjAnpqiB?=
 =?us-ascii?Q?60AoDl2gO4RwDS9V5gCqxJpk6nXTM0UG9U871FSkVHZTbKODMjRvr/1n+79a?=
 =?us-ascii?Q?Su7ixI95gW4HY+SgQsKB6BXWyThdSf6+50vLq4RtgZToEXc+PTv+ej/bxIgY?=
 =?us-ascii?Q?0zOCjg7/vVyalm5o3vNf4PnOZFDuvMSun3DpRiZlZzj5yPrNRU87S45yPSH+?=
 =?us-ascii?Q?rMT0d9rECCLWQdJtHTDWn2XciYKIsj3H050bZNSV6ndsXM2f0/RexxcHUY78?=
 =?us-ascii?Q?rQX1z9ZqEk1N1demk0C+s9ewzLJW1i1zCpT0BsyvF/VsuAopCrEoGbt3PSLB?=
 =?us-ascii?Q?Ni3cBG84DaQP0Dh8KD8A+574mHgwoCcWRKbIoV5cb4WTojOFNj4WaLhaaJjT?=
 =?us-ascii?Q?4HDf0BngoatwHTg/I8h/6FywRWGA4Z+6mmYqmow+yitKDcxd7vhpBgwRFEUy?=
 =?us-ascii?Q?uhKg5+M3Qu6X+R6z0NNWos4PexeAUm9vtpd/9tetMR87+f1jjTbGRPVwdnNy?=
 =?us-ascii?Q?xY545sbo9xw+4SwoMBTrjQybGh5mQEoDSna66iZ6mKC9uyc9ZR6eQXnGiPUg?=
 =?us-ascii?Q?bfrVvzfHnf0cIzbcYO7l5azX1EREyecNTVG41SJkOWHsN5ApiNA9HXqhmDRk?=
 =?us-ascii?Q?4wyWlaOOGXkC4NLn2aDlYee0rNRQfl/NLaLq6/GvMviIVWANLNW/2LWT4Zrv?=
 =?us-ascii?Q?58BRNKgcaAKAKgNZJfJFGvEGILN6mqnD7QliyapO1OU/FFc+f2W+KO3JVsfx?=
 =?us-ascii?Q?Wo6WvzEfN1Eg7LxAUNWSJtU4okv3EOBr4EDmgl+n4Q6qBIjEpf0g9MdHyCUH?=
 =?us-ascii?Q?IS9wvwNZh1ttnxOSFDgxV74wd3UNQXdOEcoFPe+EwiWD6YIf01ZoqbzhY6X2?=
 =?us-ascii?Q?E3zBk6awQDYGLp6mXomjaXUkip/3pNOoq5rlBEiHijak5tIIl8HjH4ecsaAh?=
 =?us-ascii?Q?59M6mxlHLfns85k5v9Nwgtr/e6wtrjAFKOi06vf4mI1EgfFxzblsmZegIRRh?=
 =?us-ascii?Q?UR0uaE3/+xu79h19C/Jfg5KcSoKrkLZaL4pUHgzRscV6nTBrbz2W3rXRi6ol?=
 =?us-ascii?Q?l89m5hC68r11L9i2aDFHHrCwnn+pjLntFwkbnXnLCBrHBbPj8fP4gyzDN7Zq?=
 =?us-ascii?Q?MgsH2rNoWIW5GokYSYQMLGT9+Xc4vTXM6AZR2pij+ByMOApjUY7LEeXWdAlE?=
 =?us-ascii?Q?L/XQAR8GwPjOMWg+PyCnqx4d3dyNUbtm+bWXVo/2zAWJjPor2gLnSyyHWOY6?=
 =?us-ascii?Q?Hdv4RX8gwL2fvJnICG6ecfOLqC5ekOLpQQPq+YmDYECOCEd1pM4CE42hlAHY?=
 =?us-ascii?Q?LrPJvVd66xZpnfH5eRTF5ImIdzXSnB7hdTfGhG/Ih1TveUb77jnHugYTHhiM?=
 =?us-ascii?Q?1CYgrKHVBdkfRuZd2IJBtZu81AioCHHXRd1zU2RGJNvpTolPa0zmSJv21dLY?=
 =?us-ascii?Q?QFz05v+7saL9jRNvAvUricEW/1QoNXGo0++GRirgr4hKCVqViPVwiE5e/34X?=
 =?us-ascii?Q?O+v3UsqlayFAYcpUqcjNC6vs34euvFxLsXChXof5f37snvF3aZ4J7/+jF4lE?=
 =?us-ascii?Q?3c/hGjYKZWq+FAVMiqOxOQ50z1CBaHSkzp6Cpc6D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?gHtAZWcDNRcmsrazsAdvkE/t0lanchm6V5hXMVWfB9EMIvroEM0CzewTXq3V?=
 =?us-ascii?Q?TTdhDCP+xhHGJMEsgwyQp2Z53Zfi4+NkY7jzQI31HkS+i0O8x092OBY5OgJf?=
 =?us-ascii?Q?2tzV8CO/0BRSCIE0N9+53HG+eE/ubL+GTas9YfIs2GxjCG0oZFN9IzHvq2NG?=
 =?us-ascii?Q?fnK2WSafjnfRXLLjubYmET61IDIHb9JXPoBlXfxlRGwRmHpnYMmbFmaFOnuD?=
 =?us-ascii?Q?z3loC0LikYntyJI+UdecbmD55URr8B7Y5aVBordaPklWuLp02CQhH/bYOVoC?=
 =?us-ascii?Q?7QXL0s6SmfjTyLrDtQ9XY9FEFn98O8ybrdtJojU602wNYvLYLiMbaFnzWsDG?=
 =?us-ascii?Q?9AtFvDwZ8/ABD6xMyrIL6Gzp6jK1xjyVMkdLuA2hnyEFhXpBRi11vAbO8/tG?=
 =?us-ascii?Q?j1HlKG5F/a6W26ifIE4lWIfRJIMSaCCWtZZLcY1IERCawpNZ4QhQxhdcOS+W?=
 =?us-ascii?Q?qiRMxTpLowMo66R8inwXPM5rLwjjDbdBig3IDoLiQw47sznRXzBLWqSr0V+8?=
 =?us-ascii?Q?fLu1squf37iUHFoT/MGrD1lz9sg4+LZWworejeh2IrZPa8czfI0QRmbR0HUe?=
 =?us-ascii?Q?oKCpICQGsAPajwivL+HA5BxWaKmKhDYHCYbSWw3sZTOxkVDYwjqZoUts/y6f?=
 =?us-ascii?Q?0yBgLi+1SwkOiEWKLApe2CsIjkM8DzyLOue2Gh9nwRZBLGY58zu7Qk0znHeC?=
 =?us-ascii?Q?fKpIYKnRKtnVeupStnETAcf2ouDHQ/63lRORL4TfWHpAgh5ug51DzDzxITwQ?=
 =?us-ascii?Q?NVY1hc1v1M7PmclX8UaxdsAjQUveObLrxiv76mq7QE4X3uUuiHWFIAyj7Qae?=
 =?us-ascii?Q?OL7SEInjjKKIq/wHoUPWYTkgu0zAKXinKQX7lLf/qO3n/Qab9ked0nBCbwTZ?=
 =?us-ascii?Q?blOh77HuX+/tTCEMlISQwNDDlvTqOiKbK5ChcsYljfsXYxrPNEjkGx3TREk0?=
 =?us-ascii?Q?eJzZXCKpAvhDJxIclVMKJwdzVQGOKyyQ45ANJb9OUnawsFEu3/cVyaQDMUts?=
 =?us-ascii?Q?Wa5PjXt5FU5vPw+t/+6DEwgALQ=3D=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c689d963-1491-4714-1154-08db2c25b7dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 05:07:51.2497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2C5NgU1QDaGje3+YF4EvH1qPDGtZul5ZTWs1N3CF9Rp+Q9pLQ5P6B+/6YIYOmsECdl9TTp6T5ORdIMTfR4/4Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
X-Proofpoint-GUID: bMVM6whM8Woy4OIy-oX9KE3ddiWBl9Lo
X-Proofpoint-ORIG-GUID: bMVM6whM8Woy4OIy-oX9KE3ddiWBl9Lo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_02,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303240040
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice,

>On 3/16/2023 12:41 PM, Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote=
:
>From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>Sent: Thursday, March 16, 2023 12:41 PM
>To: Minas Harutyunyan <hminas@synopsys.com>; gregkh@linuxfoundation.org;
>maz@kernel.org; m.szyprowski@samsung.com
>Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; linux-stm32@s=
t-
>md-mailman.stormreply.com; amelie.delaunay@foss.st.com;
>alexandre.torgue@foss.st.com; fabrice.gasnier@foss.st.com
>Subject: [PATCH v2] usb: dwc2: fix a devres leak in hw_enable upon suspend
>resume
>
>Each time the platform goes to low power, PM suspend / resume routines
>call: __dwc2_lowlevel_hw_enable -> devm_add_action_or_reset().
>This adds a new devres each time.
>This may also happen at runtime, as dwc2_lowlevel_hw_enable() can be calle=
d
>from udc_start().
>
>This can be seen with tracing:
>- echo 1 > /sys/kernel/debug/tracing/events/dev/devres_log/enable
>- go to low power
>- cat /sys/kernel/debug/tracing/trace
>
>A new "ADD" entry is found upon each low power cycle:
>... devres_log: 49000000.usb-otg ADD 82a13bba devm_action_release (8 bytes=
)
>... devres_log: 49000000.usb-otg ADD 49889daf devm_action_release (8 bytes=
)
>...
>
>A second issue is addressed here:
>- regulator_bulk_enable() is called upon each PM cycle (suspend/resume).
>- regulator_bulk_disable() never gets called.
>
>So the reference count for these regulators constantly increase, by one up=
on
>each low power cycle, due to missing regulator_bulk_disable() call in
>__dwc2_lowlevel_hw_disable().
>
>The original fix that introduced the devm_add_action_or_reset() call, fixe=
d
>an issue during probe, that happens due to other errors in
>dwc2_driver_probe() -> dwc2_core_reset(). Then the probe fails without
>disabling regulators, when dr_mode =3D=3D USB_DR_MODE_PERIPHERAL.
>
>Rather fix the error path: disable all the low level hardware in the error
>path, by using the "hsotg->ll_hw_enabled" flag. Checking dr_mode has been
>introduced to avoid a dual call to dwc2_lowlevel_hw_disable().
>"ll_hw_enabled" should achieve the same (and is used currently in the
>remove() routine).
>
>Fixes: 54c196060510 ("usb: dwc2: Always disable regulators on driver
>teardown")
>Fixes: 33a06f1300a7 ("usb: dwc2: Fix error path in gadget registration")
>Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Tested-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>

>---
>Changes in v2: commit message updated to remove useless tags
>---
> drivers/usb/dwc2/platform.c | 16 ++--------------
> 1 file changed, 2 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c ind=
ex
>262c13b6362a..d1589ba7d322 100644
>--- a/drivers/usb/dwc2/platform.c
>+++ b/drivers/usb/dwc2/platform.c
>@@ -91,13 +91,6 @@ static int dwc2_get_dr_mode(struct dwc2_hsotg *hsotg)
> 	return 0;
> }
>
>-static void __dwc2_disable_regulators(void *data) -{
>-	struct dwc2_hsotg *hsotg =3D data;
>-
>-	regulator_bulk_disable(ARRAY_SIZE(hsotg->supplies), hsotg->supplies);
>-}
>-
> static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)  {
> 	struct platform_device *pdev =3D to_platform_device(hsotg->dev); @@ -
>108,11 +101,6 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg
>*hsotg)
> 	if (ret)
> 		return ret;
>
>-	ret =3D devm_add_action_or_reset(&pdev->dev,
>-				       __dwc2_disable_regulators, hsotg);
>-	if (ret)
>-		return ret;
>-
> 	if (hsotg->clk) {
> 		ret =3D clk_prepare_enable(hsotg->clk);
> 		if (ret)
>@@ -168,7 +156,7 @@ static int __dwc2_lowlevel_hw_disable(struct dwc2_hsot=
g
>*hsotg)
> 	if (hsotg->clk)
> 		clk_disable_unprepare(hsotg->clk);
>
>-	return 0;
>+	return regulator_bulk_disable(ARRAY_SIZE(hsotg->supplies),
>+hsotg->supplies);
> }
>
> /**
>@@ -607,7 +595,7 @@ static int dwc2_driver_probe(struct platform_device
>*dev)
> 	if (hsotg->params.activate_stm_id_vb_detection)
> 		regulator_disable(hsotg->usb33d);
> error:
>-	if (hsotg->dr_mode !=3D USB_DR_MODE_PERIPHERAL)
>+	if (hsotg->ll_hw_enabled)
> 		dwc2_lowlevel_hw_disable(hsotg);
> 	return retval;
> }
>--
>2.25.1

