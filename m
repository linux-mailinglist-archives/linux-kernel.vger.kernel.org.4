Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EE6649219
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLKCy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLKCy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:54:27 -0500
Received: from mail-m12746.qiye.163.com (mail-m12746.qiye.163.com [115.236.127.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB0EA1A1;
        Sat, 10 Dec 2022 18:54:24 -0800 (PST)
Received: from [IPV6:240e:3b7:3277:4a60:8d29:b66f:578c:d71b] (unknown [IPV6:240e:3b7:3277:4a60:8d29:b66f:578c:d71b])
        by mail-m12746.qiye.163.com (Hmail) with ESMTPA id 80169BC0196;
        Sun, 11 Dec 2022 10:54:18 +0800 (CST)
Message-ID: <fd20e5c4-34fa-3ab1-71cd-13e4febc3799@sangfor.com.cn>
Date:   Sun, 11 Dec 2022 10:54:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] scsi: iscsi_tcp: Fix UAF when access shost attr during
 session logout
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>, lduncan@suse.com,
        cleech@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209082247.6330-1-dinghui@sangfor.com.cn>
 <ae9ee90e-e890-e054-6cf9-8acadd6012b9@oracle.com>
From:   dinghui <dinghui@sangfor.com.cn>
In-Reply-To: <ae9ee90e-e890-e054-6cf9-8acadd6012b9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTE5NVh5LHxoeTBhOSkhKSFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTExBTxpNS0FDH0lCQRlNTR1BTkxDGEEfTEoZWVdZFhoPEhUdFF
        lBWU9LSFVKSktPSEhVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006DDo*GD0jFkk5ShBDIUpR
        LiswC0xVSlVKTUxLTElMSU5CSUxIVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUxMQU8aTUtBQx9JQkEZTU0dQU5MQxhBH0xKGVlXWQgBWUFKSktISzcG
X-HM-Tid: 0a84ff1ad28cb219kuuu80169bc0196
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/11 6:04 上午, Mike Christie wrote:
> On 12/9/22 2:22 AM, Ding Hui wrote:
>> During iscsi session logout, if another task accessing shost ipaddress
>> attr at this time, we can get a KASAN UAF report like this:
>>
>> [  276.941685] ==================================================================
>> [  276.942144] BUG: KASAN: use-after-free in _raw_spin_lock_bh+0x78/0xe0
>> [  276.942535] Write of size 4 at addr ffff8881053b45b8 by task cat/4088
>> [  276.943511] CPU: 2 PID: 4088 Comm: cat Tainted: G            E      6.1.0-rc8+ #3
>> [  276.943997] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>> [  276.944470] Call Trace:
>> [  276.944943]  <TASK>
>> [  276.945397]  dump_stack_lvl+0x34/0x48
>> [  276.945887]  print_address_description.constprop.0+0x86/0x1e7
>> [  276.946421]  print_report+0x36/0x4f
>> [  276.947358]  kasan_report+0xad/0x130
>> [  276.948234]  kasan_check_range+0x35/0x1c0
>> [  276.948674]  _raw_spin_lock_bh+0x78/0xe0
>> [  276.949989]  iscsi_sw_tcp_host_get_param+0xad/0x2e0 [iscsi_tcp]
>> [  276.951765]  show_host_param_ISCSI_HOST_PARAM_IPADDRESS+0xe9/0x130 [scsi_transport_iscsi]
>> [  276.952185]  dev_attr_show+0x3f/0x80
>> [  276.953005]  sysfs_kf_seq_show+0x1fb/0x3e0
>> [  276.953401]  seq_read_iter+0x402/0x1020
>> [  276.954260]  vfs_read+0x532/0x7b0
>> [  276.955113]  ksys_read+0xed/0x1c0
>> [  276.955952]  do_syscall_64+0x38/0x90
>> [  276.956347]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [  276.956769] RIP: 0033:0x7f5d3a679222
>> [  276.957161] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 32 c0 0b 00 e8 a5 fe 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
>> [  276.958009] RSP: 002b:00007ffc864d16a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>> [  276.958431] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f5d3a679222
>> [  276.958857] RDX: 0000000000020000 RSI: 00007f5d3a4fe000 RDI: 0000000000000003
>> [  276.959281] RBP: 00007f5d3a4fe000 R08: 00000000ffffffff R09: 0000000000000000
>> [  276.959682] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000020000
>> [  276.960126] R13: 0000000000000003 R14: 0000000000000000 R15: 0000557a26dada58
>> [  276.960536]  </TASK>
>> [  276.961357] Allocated by task 2209:
>> [  276.961756]  kasan_save_stack+0x1e/0x40
>> [  276.962170]  kasan_set_track+0x21/0x30
>> [  276.962557]  __kasan_kmalloc+0x7e/0x90
>> [  276.962923]  __kmalloc+0x5b/0x140
>> [  276.963308]  iscsi_alloc_session+0x28/0x840 [scsi_transport_iscsi]
>> [  276.963712]  iscsi_session_setup+0xda/0xba0 [libiscsi]
>> [  276.964078]  iscsi_sw_tcp_session_create+0x1fd/0x330 [iscsi_tcp]
>> [  276.964431]  iscsi_if_create_session.isra.0+0x50/0x260 [scsi_transport_iscsi]
>> [  276.964793]  iscsi_if_recv_msg+0xc5a/0x2660 [scsi_transport_iscsi]
>> [  276.965153]  iscsi_if_rx+0x198/0x4b0 [scsi_transport_iscsi]
>> [  276.965546]  netlink_unicast+0x4d5/0x7b0
>> [  276.965905]  netlink_sendmsg+0x78d/0xc30
>> [  276.966236]  sock_sendmsg+0xe5/0x120
>> [  276.966576]  ____sys_sendmsg+0x5fe/0x860
>> [  276.966923]  ___sys_sendmsg+0xe0/0x170
>> [  276.967300]  __sys_sendmsg+0xc8/0x170
>> [  276.967666]  do_syscall_64+0x38/0x90
>> [  276.968028]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [  276.968773] Freed by task 2209:
>> [  276.969111]  kasan_save_stack+0x1e/0x40
>> [  276.969449]  kasan_set_track+0x21/0x30
>> [  276.969789]  kasan_save_free_info+0x2a/0x50
>> [  276.970146]  __kasan_slab_free+0x106/0x190
>> [  276.970470]  __kmem_cache_free+0x133/0x270
>> [  276.970816]  device_release+0x98/0x210
>> [  276.971145]  kobject_cleanup+0x101/0x360
>> [  276.971462]  iscsi_session_teardown+0x3fb/0x530 [libiscsi]
>> [  276.971775]  iscsi_sw_tcp_session_destroy+0xd8/0x130 [iscsi_tcp]
>> [  276.972143]  iscsi_if_recv_msg+0x1bf1/0x2660 [scsi_transport_iscsi]
>> [  276.972485]  iscsi_if_rx+0x198/0x4b0 [scsi_transport_iscsi]
>> [  276.972808]  netlink_unicast+0x4d5/0x7b0
>> [  276.973201]  netlink_sendmsg+0x78d/0xc30
>> [  276.973544]  sock_sendmsg+0xe5/0x120
>> [  276.973864]  ____sys_sendmsg+0x5fe/0x860
>> [  276.974248]  ___sys_sendmsg+0xe0/0x170
>> [  276.974583]  __sys_sendmsg+0xc8/0x170
>> [  276.974891]  do_syscall_64+0x38/0x90
>> [  276.975216]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> We can easily reproduce by two tasks:
>> 1. while :; do iscsiadm -m node --login; iscsiadm -m node --logout; done
>> 2. while :; do cat /sys/devices/platform/host*/iscsi_host/host*/ipaddress; done
>>
>>              iscsid                |        cat
>> ----------------------------------+-------------------------------------------------
>> |- iscsi_sw_tcp_session_destroy   |
>>    |- iscsi_session_teardown       |
>>      |- device_release             |
>>        |- iscsi_session_release    |  |- dev_attr_show
>>          |- kfree                  |    |- show_host_param_ISCSI_HOST_PARAM_IPADDRESS
>>                                    |      |- iscsi_sw_tcp_host_get_param
>>                                    |        |- r/w tcp_sw_host->session (UAF)
>>    |- iscsi_host_remove            |
>>    |- iscsi_host_free              |
>>
>> Since shost hold a pointer to session which is belong to cls_session by its
>> priv tcp_sw_host, so we should get a ref of cls_session, and after
>> iscsi_host_remove() the sysfs is cleared, then we can drop the ref.
>>
> Nice bug report and thanks for the patch. I think though we should just
> split the removal from the freeing. The removal will wait on users
> accessing sysfs files for us, so once they return we know we can just
> free things.
>
> Something like this:

I applied your patch, and it works well.


Since this is more reasonable, could you ignore mine and submit your 
patch instead please? I appreciate it.


-- 
Thanks,
-dinghui

>
> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> index 5fb1f364e815..751e4b19798b 100644
> --- a/drivers/scsi/iscsi_tcp.c
> +++ b/drivers/scsi/iscsi_tcp.c
> @@ -982,10 +982,12 @@ static void iscsi_sw_tcp_session_destroy(struct iscsi_cls_session *cls_session)
>   	if (WARN_ON_ONCE(session->leadconn))
>   		return;
>   
> +	iscsi_session_remove(cls_session);
> +	iscsi_host_remove(shost, false);
> +
>   	iscsi_tcp_r2tpool_free(cls_session->dd_data);
> -	iscsi_session_teardown(cls_session);
>   
> -	iscsi_host_remove(shost, false);
> +	iscsi_session_free(cls_session);
>   	iscsi_host_free(shost);
>   }
>   
> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
> index ef2fc860257e..235957de1164 100644
> --- a/drivers/scsi/libiscsi.c
> +++ b/drivers/scsi/libiscsi.c
> @@ -3104,17 +3104,27 @@ iscsi_session_setup(struct iscsi_transport *iscsit, struct Scsi_Host *shost,
>   }
>   EXPORT_SYMBOL_GPL(iscsi_session_setup);
>   
> -/**
> - * iscsi_session_teardown - destroy session, host, and cls_session
> - * @cls_session: iscsi session
> +/*
> + * issi_session_remove - Remove session from iSCSI class.
>    */
> -void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
> +void iscsi_session_remove(struct iscsi_cls_session *cls_session)
>   {
>   	struct iscsi_session *session = cls_session->dd_data;
> -	struct module *owner = cls_session->transport->owner;
>   	struct Scsi_Host *shost = session->host;
>   
>   	iscsi_remove_session(cls_session);
> +	iscsi_host_dec_session_cnt(shost);
> +}
> +EXPORT_SYMBOL_GPL(iscsi_session_remove);
> +
> +/**
> + * iscsi_session_free - Free iscsi session and it's resources
> + * @cls_session: iscsi session
> + */
> +void iscsi_session_free(struct iscsi_cls_session *cls_session)
> +{
> +	struct iscsi_session *session = cls_session->dd_data;
> +	struct module *owner = cls_session->transport->owner;
>   
>   	iscsi_pool_free(&session->cmdpool);
>   	kfree(session->password);
> @@ -3132,10 +3142,19 @@ void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
>   	kfree(session->discovery_parent_type);
>   
>   	iscsi_free_session(cls_session);
> -
> -	iscsi_host_dec_session_cnt(shost);
>   	module_put(owner);
>   }
> +EXPORT_SYMBOL_GPL(iscsi_session_free);
> +
> +/**
> + * iscsi_session_teardown - destroy session and cls_session
> + * @cls_session: iscsi session
> + */
> +void iscsi_session_teardown(struct iscsi_cls_session *cls_session)
> +{
> +	iscsi_session_remove(cls_session);
> +	iscsi_session_free(cls_session);
> +}
>   EXPORT_SYMBOL_GPL(iscsi_session_teardown);
>   
>   /**
> diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
> index 695eebc6f2c8..5cdeff776ce2 100644
> --- a/include/scsi/libiscsi.h
> +++ b/include/scsi/libiscsi.h
> @@ -422,6 +422,8 @@ extern int iscsi_host_get_max_scsi_cmds(struct Scsi_Host *shost,
>   extern struct iscsi_cls_session *
>   iscsi_session_setup(struct iscsi_transport *, struct Scsi_Host *shost,
>   		    uint16_t, int, int, uint32_t, unsigned int);
> +extern void iscsi_session_remove(struct iscsi_cls_session *cls_session);
> +extern void iscsi_session_free(struct iscsi_cls_session *cls_session);
>   extern void iscsi_session_teardown(struct iscsi_cls_session *);
>   extern void iscsi_session_recovery_timedout(struct iscsi_cls_session *);
>   extern int iscsi_set_param(struct iscsi_cls_conn *cls_conn,
>
>
