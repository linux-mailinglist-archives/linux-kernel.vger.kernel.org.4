Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813AC6DE5CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjDKUeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDKUeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:34:00 -0400
Received: from DM4PR02CU001.outbound.protection.outlook.com (mail-centralusazon11012012.outbound.protection.outlook.com [52.101.63.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73813C11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG4JtogVlmjdQU5liI3llxJuHhsJwasWrY6xSimiAMs47wl6Nf4KoTRmN1x7psKL3YvYD3tZ4JFKe4PSik2UEiAw7ZDBwOdESdQpFrKway2fFSrPC77uOx7avHKCh3J0DRqWxtl1SmTaLqnt9EnxKp6Q6JJBHlZ1EdCi9LZK5ON2Uq5DzvphThbMlGcDX7gI4PSrAD4AsPGrlQ0FthP2bl32Tk0z3TZINthgCYdVOKD25/CGDz3e4kg8ldKEcskzxZgmAysszpFkR0RO1jzWY6Uajc6ynq16v3evbrmeHKnQIauLzSCwobatFXMFJ8HFwd/Rjus+zUjeVF8GtRhs0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxIyfNIS3xbaZWXSMzaSUk+oVxo9fCZWAgSBRSdaJy4=;
 b=nf6Vmo2hqJuhHDY4wmUEv/avIKo38TTgEqQ4XyXCyxsZX4vGI76ZwBGyysUlhij1Qj3yevLN9qsko7aUsDf/6W00PhGO4WVh15eUinyD1C/pKrYldjbqDTzsnRESTz2xxF+yc5AQhepatxXBogL8xWtoeE0BS0IpFaY/BDeW2DxTRXUIwEPuCWnAUdLmaPFUBBTESv65vPki52PEIk0xiJ/96474VOkpzjuQwrCdHzPqh/0J8Qr90vlPzi7eBYGAY0tmS7CS1oJWi5opOZgWlQZp+vLKbrpsnowoR2ICd8lpm5T62x0IBpogNhhIppKozCSabUCiG1qkQc4qKj0yyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxIyfNIS3xbaZWXSMzaSUk+oVxo9fCZWAgSBRSdaJy4=;
 b=RWhy/w7ng6Hh1m1uG0CL8jfV+K7Pi1d92USX7ZqQrdtG9KcLVBamAQBzjK4bC3QIpwnXwPwAHnyRtOHQeNrY5JRpq1qGB7vxj2n5KgtWhFDpcIXMHGOdsefdhskp6oJs0ks5EzO8ZgMnIS3nrhU0ZNvrsZQwnYS+KjddLaVcIG8=
Received: from DM6PR05MB3962.namprd05.prod.outlook.com (2603:10b6:5:8a::15) by
 BL3PR05MB9138.namprd05.prod.outlook.com (2603:10b6:208:3b9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Tue, 11 Apr 2023 20:33:53 +0000
Received: from DM6PR05MB3962.namprd05.prod.outlook.com
 ([fe80::3ef:c86d:26ee:7728]) by DM6PR05MB3962.namprd05.prod.outlook.com
 ([fe80::3ef:c86d:26ee:7728%4]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 20:33:53 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmci_host: fix a race condition in vmci_host_poll()
 causing GPF
Thread-Topic: [PATCH] vmci_host: fix a race condition in vmci_host_poll()
 causing GPF
Thread-Index: AQHZYKPxc6PBBnY1f0a/+U3wsDlbia8RjXSAgAGj/ACAE3cXAA==
Date:   Tue, 11 Apr 2023 20:33:53 +0000
Message-ID: <20CBCA23-E535-457B-8CD6-2D59C3E97C80@vmware.com>
References: <ZCGFsdBAU4cYww5l@dragonet> <ZCQPuaps5rCtGAb2@kroah.com>
 <ZCVwCNbuLDmiZ58w@dragonet>
In-Reply-To: <ZCVwCNbuLDmiZ58w@dragonet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB3962:EE_|BL3PR05MB9138:EE_
x-ms-office365-filtering-correlation-id: 9344de79-b019-4c63-3f0e-08db3acc10ff
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB3962.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(83380400001)(186003)(71200400001)(33656002)(53546011)(6506007)(6512007)(6486002)(36756003)(478600001)(54906003)(316002)(38070700005)(86362001)(91956017)(8676002)(66446008)(6916009)(64756008)(66476007)(66556008)(4326008)(66946007)(76116006)(2906002)(41300700001)(5660300002)(8936002)(38100700002)(122000001)(2616005)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B47B44213E533D46A890E502CFF7E5DC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB3962.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9344de79-b019-4c63-3f0e-08db3acc10ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 20:33:53.5598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eG6+uZSGGko+DfccIIJGstGwUgIgaWPjK3dRsZBFeizymPNd7jAJIXnN/K0FbnQl10LdDg46pzHF/neDWvlfZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR05MB9138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 30, 2023, at 4:18 AM, Dae R. Jeong <threeearcat@gmail.com> wrote:
>=20
> !! External Email
>=20
> On Wed, Mar 29, 2023 at 12:15:21PM +0200, Greg KH wrote:
>> On Mon, Mar 27, 2023 at 09:01:53PM +0900, Dae R. Jeong wrote:
>>> During fuzzing, a general protection fault is observed in
>>> vmci_host_poll().
>>>=20
>>> general protection fault, probably for non-canonical address 0xdffffc00=
00000019: 0000 [#1] PREEMPT SMP KASAN
>>> KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
>>> RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
>>> <- omitting registers ->
>>> Call Trace:
>>> <TASK>
>>> lock_acquire+0x1a4/0x4a0 kernel/locking/lockdep.c:5672
>>> __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>> _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:162
>>> add_wait_queue+0x3d/0x260 kernel/sched/wait.c:22
>>> poll_wait include/linux/poll.h:49 [inline]
>>> vmci_host_poll+0xf8/0x2b0 drivers/misc/vmw_vmci/vmci_host.c:174
>>> vfs_poll include/linux/poll.h:88 [inline]
>>> do_pollfd fs/select.c:873 [inline]
>>> do_poll fs/select.c:921 [inline]
>>> do_sys_poll+0xc7c/0x1aa0 fs/select.c:1015
>>> __do_sys_ppoll fs/select.c:1121 [inline]
>>> __se_sys_ppoll+0x2cc/0x330 fs/select.c:1101
>>> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>>> do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
>>> entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>=20
>>> Example thread interleaving that causes the general protection fault
>>> is as follows:
>>>=20
>>> CPU1 (vmci_host_poll)               CPU2 (vmci_host_do_init_context)
>>> -----                               -----
>>> // Read uninitialized context
>>> context =3D vmci_host_dev->context;
>>>                                    // Initialize context
>>>                                    vmci_host_dev->context =3D vmci_ctx_=
create();
>>>                                    vmci_host_dev->ct_type =3D VMCIOBJ_C=
ONTEXT;
>>>=20
>>> if (vmci_host_dev->ct_type =3D=3D VMCIOBJ_CONTEXT) {
>>>    // Dereferencing the wrong pointer
>>>    poll_wait(..., &context->host_context);
>>> }
>>>=20
>>> In this scenario, vmci_host_poll() reads vmci_host_dev->context first,
>>> and then reads vmci_host_dev->ct_type to check that
>>> vmci_host_dev->context is initialized. However, since these two reads
>>> are not atomically executed, there is a chance of a race condition as
>>> described above.
>>>=20
>>> To fix this race condition, read vmci_host_dev->context after checking
>>> the value of vmci_host_dev->ct_type so that vmci_host_poll() always
>>> reads an initialized context.
>>>=20
>>> Reported-by: Dae R. Jeong <threeearcat@gmail.com>
>>> Fixes: 8bf503991f87 ("VMCI: host side driver implementation.")
>>> Signed-off-by: Dae R. Jeong <threeearcat@gmail.com>
>>=20
>> If you author and sign-off on the patch, no need for a Reported-by: as
>> that is obvious :)
>=20
> For a student like me, two of my names are cooler than one... (shy smile =
:)...)
>=20
>> And how did you test this change?
>=20
> I attach a simple C program used in testing at the end of this email.
> I used the same C program to trigger the crash before applying the
> patch, and to test the patch after applying it.
>=20
> Before applying this patch, I inserted msleep() to trigger the crash
> easily as follows:

Hi Dae,
Thanks for your test code and for your patience.

Your test conditions are a little far from regular operating conditions.  M=
y
comments/questions are as follows:
- the test uses separate threads to do the ioctl and poll operations in par=
allel.  Normally,
  the vmx process schedules periodic poll after the host context init ioctl=
 completes
  successfully.  Also, the vmx process does not keep calling the host conte=
xt init ioctl
  once this is done.  So, the race condition shouldn't arise in the first p=
lace due to the
  way vmx works.  I understand that you are fuzzing, but just letting you k=
now the
  normal operating conditions.
- vmx process gets the vmci device handle with elevated privileges.  I beli=
eve you ran
  the test as root as well?  Since vmx can't cause the race condition, a ma=
licious app
  like your fuzzer would need root privileges to do the damage.
- how easy is it to hit the gpf without the msleep?

Overall, I don't think this is a "must fix" issue today, but I'm also not s=
ure if we should
reject it either due to the simple nature of the patch.  For arm, we may ne=
ed to add
a write barrier before 'vmci_host_dev->ct_type =3D VMCIOBJ_CONTEXT' in
vmci_host_do_init_context and a read barrier before
'context =3D vmci_host_dev->context' in your patch.

Thanks,
Vishnu

>=20
> diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vm=
ci_host.c
> index 857b9851402a..e925f7effac4 100644
> --- a/drivers/misc/vmw_vmci/vmci_host.c
> +++ b/drivers/misc/vmw_vmci/vmci_host.c
> @@ -24,6 +24,7 @@
> #include <linux/smp.h>
> #include <linux/fs.h>
> #include <linux/io.h>
> +#include <linux/delay.h>
>=20
> #include "vmci_handle_array.h"
> #include "vmci_queue_pair.h"
> @@ -168,6 +169,11 @@ static __poll_t vmci_host_poll(struct file *filp, po=
ll_table *wait)
>        struct vmci_ctx *context =3D vmci_host_dev->context;
>        __poll_t mask =3D 0;
>=20
> +       msleep(1000);
> +
> +       printk("%s, context=3D%px, ct_type=3D%d\n", __func__, context,
> +                  vmci_host_dev->ct_type);
> +
>        if (vmci_host_dev->ct_type =3D=3D VMCIOBJ_CONTEXT) {
>                /* Check for VMCI calls to this VM context. */
>                if (wait)
> @@ -341,6 +347,10 @@ static int vmci_host_do_init_context(struct vmci_hos=
t_dev *vmci_host_dev,
>        }
>=20
>        vmci_host_dev->ct_type =3D VMCIOBJ_CONTEXT;
> +
> +       printk("%s, context=3D%px, ct_type=3D%d\n", __func__,
> +                  vmci_host_dev->context, vmci_host_dev->ct_type);
> +
>        atomic_inc(&vmci_host_active_users);
>=20
>        vmci_call_vsock_callback(true);
>=20
> With this msleep(), the C program below can easily trigger the GPF.
>=20
> Then I applied the patch that I propose, and ran the same C
> program. After applying the patch, I couldn't observe the GPF.
>=20
>> thanks,
>>=20
>> greg k-h
>=20
> Best regards,
> Dae R. Jeong
>=20
> ------------->8-----------------
> #include <fcntl.h>
> #include <poll.h>
> #include <pthread.h>
> #include <signal.h>
> #include <stdio.h>
> #include <sys/ioctl.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <unistd.h>
>=20
> struct init_block {
>  int cid;
>  int flags;
> };
>=20
> int fd;
>=20
> void *th1(void *a) {
>  struct init_block s =3D {
>      .cid =3D 2,
>      .flags =3D 0,
>  };
>  ioctl(fd, 0x7a0, &s);
>  return NULL;
> }
>=20
> void *th2(void *a) {
>  struct pollfd pfd =3D {.fd =3D fd};
>  poll(&pfd, 1, 20000);
>  return NULL;
> }
>=20
> int test() {
> #define filename "/dev/vmci"
>=20
>  fd =3D openat(AT_FDCWD, filename, 0x2, 0x0);
>  int var =3D 0x10000;
>  ioctl(fd, 0x7a7, &var);
>  pthread_t pth1, pth2;
>  pthread_create(&pth1, NULL, th1, NULL);
>  pthread_create(&pth2, NULL, th2, NULL);
>  pthread_join(pth1, NULL);
>  pthread_join(pth2, NULL);
>  return 0;
> }
>=20
> int main() {
>  for (;;) {
>    pid_t pid =3D fork();
>    if (pid =3D=3D 0) {
>      test();
>    } else {
>      usleep(100 * 1000);
>      kill(pid, SIGKILL);
>    }
>  }
> }
>=20
> !! External Email: This email originated from outside of the organization=
. Do not click links or open attachments unless you recognize the sender.


