Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C406BB0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjCOMUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjCOMTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:19:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298728FBE2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678882775; x=1710418775;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W8VWJ+HXClFupQdx7dEd+qATsbyl8N6CjZ9hyMFXfSM=;
  b=Vf5Qsf40wt5cU4cDwlBS1x/A1Dy9iuogbNo9+mmyO4G+ueaAu8+gg04V
   oXjnrsTmJIgwTuDHXKHC0955kstu3ynFlwm4u+1Z/AjRCT36PPmnzzITg
   q/fkKfmFvfH/8Z2LXExpt1CESF9sxBcKgar8eqfszDfH+LM8aZ6lvBQ/e
   LxU/6VFnSN82XeqzZthfrl2tZPlf5I4wlUhjAIQDNsN0FKi3+AB8HeY5N
   GYdMMwHJlMvPTQnLYQJiULplT84Lg5jKtLrl3+kmdszHYzVBgRhw4lYoX
   EynlGvJXEN7T5LgmtwyGi2kVe48Tz75vqtCqxlI2LCpCMPdD6qTcJ3+9a
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321524543"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321524543"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 05:19:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="709663292"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="709663292"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2023 05:19:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 05:19:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 05:19:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 05:19:24 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 05:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV68V7je2SzQSJCWcXzJnIOehoN8udctvfMsMYAFz5PPt1MNdZNgtfCpZEjrJdgOU8SRP1/kpyehpqSNDSfqAtJfQKnH8yABMIryla9qHe97w1lzcH0Q4PyOaj2YONhe7+SOUBwLWT6AWPmG3mplkb/lTpJpPuhqyz7AoVrxy+orHAcU2k4dceng2VwYXOG6ns64BZwYdyHsezOg80xB0/AfCiinxnxNARFN9S0mfMy58ldph/ng1Nqpk4xK0W9HfZ76gXPEwn3CjVxFRL8KD33ZDyHfxIm50Om0hYOhlSMW9AfURnFXKfCDpFyCVLS8VBM294lia4Drj26aGEataw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCxMjXlLBBJ1ZlYBAykssi/qktG/KS06QV2r1DoUPEs=;
 b=HqXF7Hih1FIEmYzZRzi+UOMmfyqWb1C79R9uiMcKSXc7q6+oMNz3wGn0lVKyG9K8KdkFs1QiyHAZkkrZiv7wORPUiqoQI9DzL3OTvzzN4P7ceMJulGJh4Ii7wmAgtqxR+w6rzGJAoIoqH+szq7wduT8BIGz3pPE/2QlwjvaMmXvxgnk2goOhOtoa1mLCebBPd8RGbaP9hC7chgqDmaLJSe6Eo5AKWJaY3c2wfGD7VPUfbd+0aIPglpH8iXgPc25TmTiQx06Mp+LcsZrGJh1PGWcmQ3YYFxFiuU4/lxeNFUiGg3s1fMrsp6ZXhbr2tdMK2ibrHMbRoovDpYu6BMdK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 12:19:22 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239%8]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 12:19:22 +0000
Date:   Wed, 15 Mar 2023 20:20:44 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <lihuafei1@huawei.com>
CC:     <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>, <frederic@kernel.org>, <quic_neeraju@quicinc.com>,
        <paulmck@kernel.org>, <heng.su@intel.com>
Subject: [Syzkaller & bisect] There is "task hung in synchronize_rcu bisect"
 in v6.3-rc2 kernel
Message-ID: <ZBG4HOCQIlGFFcIn@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TYAPR04CA0019.apcprd04.prod.outlook.com
 (2603:1096:404:15::31) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SN7PR11MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ce7c4a-95c5-44ee-0617-08db254f824e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRXi+/pzkfl3sKkzi7mKuPXeVXpXtyjpFjIvHi/aD/F+C7dVnPd0X9JqsXIP4dRFlwO3Wifn3l9xVhCkKhVSBlQD69bpAkN/hepxDw9k53LUu9cDhKF9aVbaq6e7mmMssTgywgWQdLyTZFllA7WKPC0DLP3Ddy8j7tMYQ9acIyPMtby99K8z/HrIWKdouIEdlkh33IXeujtqfJDMyERu0SyaTIPJig7EstjAvTXJMRPUiZlwymhWWEyKRKMZKWNJE3RUvffEQpuxFr+aM1d6fFc6jVMzgN6JNHHftfrQ4oNHimMa68CZCCGwIDCD8/LVpqlXRUw0QoKg0lBE5S0rmR8Uq76dc2b2k3X2WcbmGjmzWNn2pcRCR7ETFkxlN14yxsgG7U/hBm5jEqiwPhC1Wup/q/V36Rz4dtV1mZr523uwCXJKFn7LQT+dr1QzcZMn2N+b6nzYgXXUvHhV5TOVN3XroixOP1JDJOsty74If592frzEi1Awh6KooQVtn0BRhWnG682XZlWQIo5y6hxxznZqKf/y6Xm+O52EZ5vTd2dlmlcIJf0rTRsASCI3guxTOaJw4t2gYhBdutUsDeh1tHxqMDuW5hOqttSeP6kkkA1cDx7N3ssreD5kYSLIPfZKZ6mBDTvIfeCwSn+T25NDMGX6oPwSPgAmyxknDnDaWnJU3XpTegrfSe2AtwASZGc7TAqcpy0UHHbjBOJ5sJH3mkdpq1D8eApqaS0HMb30S9WV2jmuL7RXIX/Gj9Lk0UfC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199018)(41300700001)(478600001)(8936002)(8676002)(966005)(6916009)(66476007)(66556008)(86362001)(66946007)(38100700002)(82960400001)(4326008)(26005)(6512007)(186003)(107886003)(6486002)(6666004)(44832011)(5660300002)(2906002)(6506007)(316002)(83380400001)(21314003)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BeUyctVTmQSt7mFbI6npyywkkfb2/IiGvBBI4OtHGvp2yUJ3PeUtilTEYEQf?=
 =?us-ascii?Q?p6zzeG1TQXpihze70FweBapENYOKAixqvR/PU9nV6VN2tyXsTSwO0OPWDWGL?=
 =?us-ascii?Q?bpg8c+7S6fyRYMvoVPbjg96HbFrXpT0QgvL6P7HeRfBjGRLdRvVxRbS4a3jM?=
 =?us-ascii?Q?fRkMrZKg6tNKNW1SmixxkrwK9OaMAn1P569StTdjTWuORll+8Rvm+PnZhrUX?=
 =?us-ascii?Q?ZmQcf5PZzcZhXkWC9diqmOTM+r156Hz+cRrRXwlaWXxVxAHBI7xfglpos7Xb?=
 =?us-ascii?Q?EIZLth+BcthCYJ0cpfj/hPSK/imdiVaArZVHHszmKji5lGzeLz5ixa/zLLVo?=
 =?us-ascii?Q?WMyb0qh/KPVKSMl1+H0gU4MSSyhccuZOTwA2+jLkDlRAdr6JiRas7dAoUAcB?=
 =?us-ascii?Q?IgS4OQwrBEFbrcRdPAkAXshJln5EO10SdCy8FIsNQLN7q9Sz8gaT8zhlnfuG?=
 =?us-ascii?Q?1wjyqhe6vKGqMjA5JMpTZOmMa5r+CYh9mc+xtKiSEW1IbrtW3kHyQHIdV8KT?=
 =?us-ascii?Q?gVpcYyJOmRd0pHh4SG5PA0xpR6Acb7fWQTd0L0ctJNLEYPUbieB9YOfFk8U4?=
 =?us-ascii?Q?BsbLQbAguheQTccB0nQarK1yECBAJDqd2ZcSadYE0jMZDC5BTKLlTR1GiJe7?=
 =?us-ascii?Q?RbOub0N4a1nRivPQSrFHoVyvhe2UlvBGYC1Koc0XQvPZbu9URQd25z3J2AUG?=
 =?us-ascii?Q?CsuijqDaLvUKP1sAWs0E1I2yRs4tlyAExyTgvKkq5OFybhAyf9LQ35cLL3fI?=
 =?us-ascii?Q?pe/900vs3x5QlyDTS5y9OtlrVjLplddwX4bkk1vtZA2W9zFMGoL10QW2vUBM?=
 =?us-ascii?Q?5R4kxZP6JE+s4ceI16WlOeiNO3su+lPw3iz3xOkTtFXZXE9sy+7ZeTFJ2MVt?=
 =?us-ascii?Q?HvBBeYCNppWqK7Zr6eTyTkQQWfk5J2gifGztwQE8qLEUT8cQFglRGg6AYc/z?=
 =?us-ascii?Q?3Bq7zhcdGTegndJoWx5Gny1HMFaX5n/AhhSQXxGmb+QDoKU6VuA/vrZzGe4q?=
 =?us-ascii?Q?rAmyE8voxlg3+2RYOZvic9wOO5SG4hgdS8zPkacnzWmInXlMRo+gKD+5T0An?=
 =?us-ascii?Q?7M/tjfKy9jMwdNtAilWKezWlQAzMUkwWq7FdwI3lXAyQMOaaLPYxESZ5L8tj?=
 =?us-ascii?Q?rOeyutHT1e2M/IzN+ZPQEsWevKE9lxSeRmwn5ULq2fnlgZfaAXBbDaV5uRk8?=
 =?us-ascii?Q?ZHZl1S1EK5ONAElCyo4a+jXW83s0ooDkYpJLyF3XzZZlhQrq/gnV+FC77Zx8?=
 =?us-ascii?Q?l94xDIjLyNM+5wRk8e4Y4bPdOhvxxDb/QrqTj5jM7RZ+Salsa3RTsOCKsueC?=
 =?us-ascii?Q?+qEVRB9uz//wMcQv6Y41cLpMijRbcdp4Q8lwKTYqgs7xAiVgN1j9i82PjWDd?=
 =?us-ascii?Q?MiI1wSwFm+NrcrGyk2We/zHnFNo2kmAjoF90kEVcMZHPjwpRjXz10rTrzAkA?=
 =?us-ascii?Q?fx8ZS0cznhLGObg9TzgxRQawXIqQ3bghmxn2SRKIcOHzLJ4j6gmvzbSvGeg6?=
 =?us-ascii?Q?M4r3uDxGQA4eYu2lH1NhjavQSsmLSCYyhEnLKU3uDh961eRX76kZTzZOHwe+?=
 =?us-ascii?Q?tjaQxCL+m5d0jGv02AM8GHNHreSjpUNJ7m4dqx29p5l6RlOKy25zjOK4ZFiU?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ce7c4a-95c5-44ee-0617-08db254f824e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 12:19:22.3571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjzBvZDlQ37oK17jUg1SwjldR+/Bg2Vylwaay+6jMdeGZ/F4b2swtHuWwIweifiN/FNYvbMPuR4voJMnKOLQ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7420
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li Huafei and kernel experts,

Greeting!

Platform: x86 platforms
There is "task hung in synchronize_rcu bisect" in v6.3-rc2 kernel in guest:

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230315_023443_synchronize_rcu
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230315_023443_synchronize_rcu/repro.c
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230315_023443_synchronize_rcu/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230315_023443_synchronize_rcu/bisect_info.log
v6.3-rc2 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230315_023443_synchronize_rcu/eeac8ede17557680855031c6f305ece2378af326_dmesg.log
"
[   24.844767] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=330 'systemd'
[   31.392668] hrtimer: interrupt took 10726570 ns
[   62.552360] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 2942 jiffies old.
[   92.760386] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 10494 jiffies old.
[  182.808389] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 33006 jiffies old.
[  300.120396] INFO: task repro:540 blocked for more than 147 seconds.
[  300.120937]       Not tainted 6.3.0-rc2-eeac8ede1755+ #1
[  300.121351] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.121888] task:repro           state:D stack:0     pid:540   ppid:538    flags:0x00004006
[  300.122552] Call Trace:
[  300.122835]  <TASK>
[  300.123267]  __schedule+0x40a/0xc90
[  300.124351]  ? wait_for_completion+0x7b/0x180
[  300.124772]  schedule+0x5b/0xe0
[  300.125156]  schedule_timeout+0x50b/0x670
[  300.125829]  ? schedule_timeout+0x9/0x670
[  300.126414]  ? wait_for_completion+0x7b/0x180
[  300.126826]  wait_for_completion+0xa6/0x180
[  300.127478]  __wait_rcu_gp+0x136/0x160
[  300.127922]  ? __pfx_arch_ftrace_ops_list_func+0x10/0x10
[  300.128639]  synchronize_rcu_tasks_generic.part.24+0x3b/0x60
[  300.129092]  ? __pfx_call_rcu_tasks+0x10/0x10
[  300.129499]  ? __pfx_wakeme_after_rcu+0x10/0x10
[  300.130115]  ? verify_cpu+0x10/0x100
[  300.130574]  synchronize_rcu_tasks_generic+0x24/0x70
[  300.131020]  synchronize_rcu_tasks+0x19/0x20
[  300.131438]  ftrace_shutdown+0x1cc/0x410
[  300.132206]  unregister_ftrace_function+0x35/0x230
[  300.132722]  ? __sanitizer_cov_trace_switch+0x57/0xa0
[  300.133311]  perf_ftrace_event_register+0x95/0xf0
[  300.133750]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  300.134190]  perf_trace_destroy+0x3a/0xa0
[  300.134590]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  300.135028]  tp_perf_event_destroy+0x1e/0x30
[  300.135473]  _free_event+0x101/0x810
[  300.136191]  put_event+0x3c/0x50
[  300.136605]  perf_event_release_kernel+0x2de/0x360
[  300.137011]  ? perf_event_release_kernel+0x9/0x360
[  300.137577]  ? __pfx_perf_release+0x10/0x10
[  300.138031]  perf_release+0x22/0x30
[  300.138434]  __fput+0x11f/0x450
[  300.139038]  ____fput+0x1e/0x30
[  300.139425]  task_work_run+0xb6/0x120
[  300.140164]  do_exit+0x547/0x1360
[  300.140632]  ? write_comp_data+0x2f/0x90
[  300.141223]  do_group_exit+0x5e/0xf0
[  300.141732]  get_signal+0x15d1/0x1600
[  300.142596]  arch_do_signal_or_restart+0x33/0x280
[  300.143463]  exit_to_user_mode_prepare+0x13b/0x210
[  300.143955]  syscall_exit_to_user_mode+0x2d/0x60
[  300.144623]  do_syscall_64+0x4a/0x90
[  300.145032]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  300.145459] RIP: 0033:0x7f2a7abd859d
[  300.145823] RSP: 002b:00007ffcc732b338 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[  300.146429] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f2a7abd859d
[  300.146930] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200004c0
[  300.147436] RBP: 00007ffcc732b350 R08: 0000000000000000 R09: 00007ffcc732b350
[  300.147938] R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000004011e0
[  300.148645] R13: 00007ffcc732b470 R14: 0000000000000000 R15: 0000000000000000
[  300.149713]  </TASK>
[  300.149978] 
[  300.149978] Showing all locks held in the system:
[  300.150435] 1 lock held by rcu_tasks_kthre/11:
[  300.150808]  #0: ffffffff83f63490 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
[  300.151849] 1 lock held by rcu_tasks_rude_/12:
[  300.152593]  #0: ffffffff83f63210 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
[  300.153645] 1 lock held by rcu_tasks_trace/13:
[  300.154013]  #0: ffffffff83f62f50 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
[  300.155078] 1 lock held by khungtaskd/29:
[  300.155425]  #0: ffffffff83f63ea0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x1b/0x1e0
[  300.156644] 2 locks held by repro/540:
[  300.156977]  #0: ffffffff840206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  300.157971]  #1: ffffffff8401cd68 (ftrace_lock){+.+.}-{3:3}, at: unregister_ftrace_function+0x2b/0x230
[  300.159005] 
[  300.159233] =============================================
[  300.159233] 
"
Bisected and found first bad commit:
"
0e792b89e6800cd9cb4757a76a96f7ef3e8b6294
ftrace: Fix use-after-free for dynamic ftrace_ops
"
After reverted the above commit on top of v6.3-rc2 kernel, this issue was gone.

And this issue could be reproduced in 2100s.

There was no this issue report in syzbot link:
https://syzkaller.appspot.com/upstream

I hope it's helpful.

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
   // You could change the bzImage_xxx as you want
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
make
make install

Thanks!
BR.
