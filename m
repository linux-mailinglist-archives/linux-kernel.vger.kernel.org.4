Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E896E232A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjDNMZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjDNMZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:25:09 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A994AF00
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WODSQopG1ib8wvq6WYfX5c8Cb8VJph+IfIHZVXgCfu0sKO9TitLjnshGl0ra942gyVsAICmYuMLbNdCvPPbhjkBrNEfqZvki14gDXQcHdOTpvPbj1ONaJEm5ZvKPgb3z/2abgiaw7jmEKT9/K0VuWmLqod//T2OJ8ICI6mNSmvgyiug1u9bmc9/yU2bcd8jXcljBnGHB3IoM+mFehTgj5FGZ48qoKYQ0Zk0Q4luzkC76udSCa74d8G8NXjhjWoF3UjKu62Nf//v5HA/vEw/JAMN9kwp2fXGFbkVWPYK7HWDDZ31c2HMwymTu1+DzQJIJUOQ70c8+cFX36IJ9Cy+Uhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2ksemgbYt0UipL7/1V4kqVbTWVueoAX+rjCNB7uI0I=;
 b=X/ZrFh4HhDglEha+z/R4xPlF5eWgMq1VrsX+sHr8bkleRklSVRZhzEZa8YB69tWZQT6FCo1eFWLXT/CyYDS3VEJ/wR44qIok6UJu3Igc3pDoqi3EmzdpxSaWL0Z9XnVKf7rZhU/nYPJHs3GfdaeX07eBuhVdqXarrgCXavhD/wQ9oSFbrKxFsFBWQqLP33LNw0tVFEKfdCDtoIqXl2N7CfWEO4ixP7Zyz+uSlnWEDbMvLFPyy/1MHUwL06UdPV3VFdqbRIYLofTx+ruDk4P+aSuDjBsTuAskRNUa1z0zWegqdolKBIrZCoj+QFhnElvPhQWze9krpraye7OAKg6WhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2ksemgbYt0UipL7/1V4kqVbTWVueoAX+rjCNB7uI0I=;
 b=Rva3RgPLbfnsBuQwjCpb/gHIG1al5nBXpoRF5WwnH8/7zx/4DkoDWTQejjS1pQasE0ox/ilQzMth8rX2z2wAIFu43uBrFBEZOVu9F+Bz3km5w4jsdqGO7P203V6iMYhFB13q2PRvoFRk3uVDxK4+bK0uWd5Ls1ftdJ2+MdhCRJ23CyTO/Ss4lVU1/8CLTnRsgewDxGVj+/Jmt7TAXWgz84Eq5UEQFWJOMto0AnlaSV4lF8a4wrgpU58K6ayVQ4QEK8VzBQjbUNagmurKI0Rn0wpqAjMrq4/0rNRuF0efYsUXuL4ntQvyLQUzWrYr2dFIwjOcXNgoNW8zA7gD+T/5Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 12:24:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 12:24:46 +0000
Date:   Fri, 14 Apr 2023 09:24:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v10 3/5] hisi_acc_vfio_pci: register debugfs for
 hisilicon migration driver
Message-ID: <ZDlGC8SUXqKNmfSe@nvidia.com>
References: <20230408074224.62608-1-liulongfang@huawei.com>
 <20230408074224.62608-4-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408074224.62608-4-liulongfang@huawei.com>
X-ClientProxiedBy: BY3PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:a03:255::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1af007-750e-421b-7693-08db3ce33bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QgT/MhZU9VEucAP59KqGf49NzGW2rzOmkVNIQ+TAz3FFScY0vACgFCTg1FA1E7nXmKTUZjOq9L1Zin4308ETOCs4I2xg86wOepEqWjievM8kJgK3YHKbODydMRcF0dXL/pvRtVmfY7/1xpGAgIOhoTDqjferVIB1fMJte6TS2Sr77Dtc01HiR8dXKM+y2KbA/+FB/G43CJVDTH09/TV0fF/WlIkaCKB/Vfdbsprfg4BjGn5oBpI1VWVcBTKezmEmpYxhYdsFs6mvmS87XN9z8Oll0upAlXaecKJIO0q/Mn3rMgTgO0O1cB4Qa9N6SOutF3snsARmWYezekzJqvxbRz+od2jq72MqKeIkCIJTZM5dyqv4HWTZZul5KAIf1M+1oboTfY30VulPyvZGIu6wG3ym/RzZqtcYfbfz9h6nhRp6dVwwGF9eUvkQxIun9irE9QXK+AVTcgOEc+cF2yfVeLzyPW+L81H8zIsQVgILU7njhlAsm67tW6/BQAceMuTr2Z+Io0ukFGsc/lHz/Abgi+H1zGMmKCRz1FE8n9BPXWCtiD8z5TKMMqSst9LCu//
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(4326008)(66946007)(6916009)(316002)(66476007)(66556008)(2616005)(83380400001)(6486002)(478600001)(8676002)(8936002)(41300700001)(38100700002)(6666004)(5660300002)(2906002)(6506007)(26005)(186003)(6512007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMiPfUcQegeYKAq9QMqrNUyP18CMRtXmXkSQMcki2ZwNyy2nqOyc7UgN/PBn?=
 =?us-ascii?Q?hlwtv+FHNRx4P1wLLMzy6DOpX2GyDf37+MCbxIiwIL7kEKWBkGwHNqMyob/w?=
 =?us-ascii?Q?PXd6ClrBB9ufQ+2ovvpz7Nn4yieqAQ5Bd3vsqcL9qD65mA4Rf2NyevDw74Q0?=
 =?us-ascii?Q?c311Gy83tsSdL4eg0nNpbIdU/NE3GVpptjKgITXxopQWgO2FSMgsfLHAigCA?=
 =?us-ascii?Q?pKKUU3atflOYzawhjTui+Kv2Kf0gqlmVB8tS0jMM6+Kh+y1Ycxqe93PBv9lR?=
 =?us-ascii?Q?FO0AMu7LducmoWYXRgeI980BWPxPAt8ikBuBeU4LwmBJ1/NkRMnisbLp5F6m?=
 =?us-ascii?Q?RHSrNDPFh90BBzHzAeb5F01+NL9/V7vl2C2T/rTMZ8tdRtiE/ldr0qp7m2Pf?=
 =?us-ascii?Q?Qvby4pBETI1XmwS/T1Tl6ulfuFbcPGT4JP+sSsPpjj4d9Okk89H/6TEiR1kL?=
 =?us-ascii?Q?dZzRBymmFX2wcxc221/8AwqRbzRDd9QWvKxqlX0WSLcN4ISh6B3pHM3YZd9H?=
 =?us-ascii?Q?Qrn8v0Lt9RlXlasbVEESiIIdYrPGqf9VceSWNeVL4Bry6a5Q4/J6boM849Mz?=
 =?us-ascii?Q?a+MOk9j/RZTwKsQiMe4O52ZOHQEWElvhDDOAHSqaK/bnk2r2HWsQp8ychVHU?=
 =?us-ascii?Q?DYwuabCxFkkniJKwYF12Tujkr+zq1Tz5z2+V2E0qag2zkcbpFBAUYpyixFRd?=
 =?us-ascii?Q?zPTdMRQ0roEhB1+5quevX8AQUTAnwQgREBrGVEWGWp5AZDiYoPQ6M450Emdq?=
 =?us-ascii?Q?IE27M20So9jTWp6nQCp0BjtbPpSVIUN72KB+KwY+DM1lNTPzRwue3nKnFBtP?=
 =?us-ascii?Q?vQeufwgwIIXlEL3njUAgZdasVu47i99HZT9PewStVfX+IBPNx0N/y4JCtl/2?=
 =?us-ascii?Q?Epf/nWZvxaiERzu7McBVy6rLZwJQxCVYPw5ZPCU+zZ/u8YQKg9HsnDWdhbKN?=
 =?us-ascii?Q?c/KFxqOsv1JlVU/OxlbgXvwPbtby1vINoqH+omyTplwPtd/EIg6BMmGzZS+S?=
 =?us-ascii?Q?6UmHhctuLeCKLCfRsKo+TuFja024Nqx7TnVCBN30SD0x36KjkQ2aSmib66a+?=
 =?us-ascii?Q?JpZoYAX085nVAUmK41n40unu9UCaUWKKRIjlMSBNmQjou9xhtA8STOHPdZTB?=
 =?us-ascii?Q?TAreXT68p9fdVkh2gfqPJcf7Dvy4XMngL5PIfd5pvtpll5PaxZjo/SHHcLBe?=
 =?us-ascii?Q?6+8Wb2E8KDfMg8PIvxzqyx0p2+oyuBPNb/1ZcQHp7tGQht25HWLCzX6GSzDd?=
 =?us-ascii?Q?JyJBQv1q2ObF1vPynN8mmtgLVoJSA2UhoN6p+0ra1DcA531i8WVvxXuA2+Wl?=
 =?us-ascii?Q?lOH4YjYWQjgaVB5cH9QtuiB3f/D2GA7iJOvb8ZzzCFJENlX4BHqn+odtKcmO?=
 =?us-ascii?Q?W5pwmxHdS2oxoL4Rq8FluRiTC3DIzHNl1uLVWA3T70wp4IFsZ0RqnLTdlZjC?=
 =?us-ascii?Q?mWBXLos/wMtELcJnhJ6MYwo24+OOkZwMICMQvwF2q+9USuKWeo3SBV+b4GTL?=
 =?us-ascii?Q?FkfjeNj55f49wQiZHc3CczQ2WbcsNu5iG7v8N8CmXPm5wfRMQ4l+GhCh74KO?=
 =?us-ascii?Q?ILCmCrvopZN+JFC52H6XNhMsfwDHhjMWJunDQaKl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1af007-750e-421b-7693-08db3ce33bae
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 12:24:46.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phPM81bPPCqUP/M+nkkrh+EynSzGa2vUYwVLX6R6eLmqeQD9agzlLUuiHG5lDtrk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 03:42:22PM +0800, Longfang Liu wrote:
> +static int hisi_acc_vf_debug_restore(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device	*vdev = &core_device->vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
> +	int ret;
> +
> +	ret = hisi_acc_vf_debug_check(seq, vdev);
> +	if (ret)
> +		goto restore_err;
> +
> +	ret = vf_qm_state_save(hisi_acc_vdev, migf);
> +	if (ret) {
> +		seq_printf(seq, "%s\n", "failed to save device data!");
> +		goto restore_err;
> +	}
> +
> +	ret = vf_qm_check_match(hisi_acc_vdev, migf);
> +	if (ret) {
> +		seq_printf(seq, "%s\n", "failed to match the VF!");
> +		goto restore_err;
> +	}
> +
> +	ret = vf_qm_load_data(hisi_acc_vdev, migf);
> +	if (ret) {
> +		seq_printf(seq, "%s\n", "failed to recover the VF!");
> +		goto restore_err;
> +	}
> +
> +	vf_qm_fun_reset(&hisi_acc_vdev->vf_qm);
> +	seq_printf(seq, "%s\n", "successful to resume device data!");
> +
> +restore_err:
> +	return 0;
> +}

This is basically an in-kernel self test, it should be protected with
some kind of VFIO selftest kconfig.

Though, I wonder why we need it??? Can't you write a trivial userspace
program under tools/testing to do this sequence with the ioctls?

> +static int hisi_acc_vf_debug_save(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device	*vdev = &core_device->vdev;
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
> +	int ret;
> +
> +	ret = hisi_acc_vf_debug_check(seq, vdev);
> +	if (ret)
> +		goto save_err;
> +
> +	ret = vf_qm_state_save(hisi_acc_vdev, migf);
> +	if (ret) {
> +		seq_printf(seq, "%s\n", "failed to save device data!");
> +		goto save_err;
> +	}
> +	seq_printf(seq, "%s\n", "successful to save device data!");
> +
> +save_err:
> +	return 0;
> +}

Same kind of commen there, this is a selftest, why does it need a
special kernel interface?

.. and so on..

I thought the non-selftesty bits were OK, maybe split the patch to
match progress

Jason
