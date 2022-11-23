Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7853F6366F6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbiKWR1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiKWR1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:27:22 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64468DA6A;
        Wed, 23 Nov 2022 09:27:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id e27so4169506ejc.12;
        Wed, 23 Nov 2022 09:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LISItnRSTvcc0povFBg+PbTpRnC7j44ZzvAZO+Dheig=;
        b=JJxXgo3yj/hkHDpYeey/PqgCAzwm+srg4Ta9jfkqTfSQBsOq+YwjM0f1aot++nJ72G
         UkxvO+FC5D0vpRbSPyVMzjQRIUdvp4xgGn3iOD/lGVpcH2CPooTN8yFwrsoAYa/dUnc/
         sUc4ecsYC/Sm++vuVTeCBMcV2vgxYl+Y4o8OagXdioKGJJPrKlNYSDkfr29iUq/TSKQ4
         Zo/Bb+lD0k6i9g++VK4BCa9MMfkruhleh/3yej/XRnAve9IfhxV+QanEjfw3SQZz120F
         8J8dnD5yVJOnGs32Q4frmsYAOSc+iJBaA+35g1+ki0nwg4efTpF3n81ygN3H06LPSiim
         SUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LISItnRSTvcc0povFBg+PbTpRnC7j44ZzvAZO+Dheig=;
        b=v7tk0vmO33c2UskqVGFepp/H+KTgSjtHl7ep+7huTByKtS+vQA4AmDSA/xfbh2tIdP
         DuFLDUU5FUXFbXYvUxqKPPpqa3S9j6DaWQFd0NP5bBLaAD+ALfBCABvFD6+bC5jtxE9h
         gDoYKQQMk6lG9H1epSY0xQTLIyKkesIRaSHSoZY7ZVDkiMoTaKGlQsvcgqeeY3NlrwJZ
         rPcki5q6dEpmuzDHYHlttX9RFR5QJXNcKRqIfb1q3OyDaMiUW7lcyZRKfEPdErMLvMpt
         fh6W+6e81QVtbsItG/HFhCgR5GGlOtcIvIdoB3fqMQ8nmO4dIT2tBQy/g1ww3eqxaHCi
         kMlw==
X-Gm-Message-State: ANoB5pnVGQba8aBsNbcajhFRMEOlf9uKVxFQBUaGTxccNkF9YA5sBzvP
        nDFhFU41Ghg1pvtjl78lAw/T7cA7gSq+RFrVtHg=
X-Google-Smtp-Source: AA0mqf6KoD/GxIAiImLxJGp8rN3yvevH19oHKE076HS2+7iX4LwzuEO7GbdqWLK+ndoUt9JjvFcISu1yxpEoXvBa9gw=
X-Received: by 2002:a17:906:e0d7:b0:7b9:a74b:f16a with SMTP id
 gl23-20020a170906e0d700b007b9a74bf16amr3881668ejb.192.1669224439001; Wed, 23
 Nov 2022 09:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20221122213040.4128105-1-haowenchao@huawei.com>
 <4d21f806-6653-5457-918c-563a3032d128@suse.com> <00f11c61-a53f-c48a-017f-4c06055ea708@huawei.com>
 <0f7258d5-ff8e-fa4e-ab8e-5125c42a6d07@suse.com>
In-Reply-To: <0f7258d5-ff8e-fa4e-ab8e-5125c42a6d07@suse.com>
From:   Wenchao Hao <haowenchao22@gmail.com>
Date:   Thu, 24 Nov 2022 01:27:07 +0800
Message-ID: <CAOptpSO=BEGWFkzT2umFXnWSyn24XR5nHc-mnTvsVb6PAn=4xA@mail.gmail.com>
Subject: Re: [PATCH] scsi:iscsi: Record session's startup mode in kernel
To:     Lee Duncan <lduncan@suse.com>
Cc:     Wenchao Hao <haowenchao@huawei.com>,
        Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 12:51 AM Lee Duncan <lduncan@suse.com> wrote:
>
> On 11/22/22 20:41, Wenchao Hao wrote:
> > On 2022/11/23 4:00, Lee Duncan wrote:
> >> On 11/22/22 13:30, Wenchao Hao wrote:
> >>> There are 3 iscsi session's startup mode which are onboot, manual and
> >>> automatic. We can boot from iSCSI disks with help of dracut's service
> >>> in initrd, which would set node's startup mode to onboot, then create
> >>> iSCSI sessions.
> >>>
> >>> While the configure of onboot mode is recorded in file of initrd stage
> >>> and would be lost when switch to rootfs. Even if we update the startup
> >>> mode to onboot by hand after switch to rootfs, it is possible that the
> >>> configure would be covered by another discovery command.
> >>>
> >>> root would be mounted on iSCSI disks when boot from iSCSI disks, if the
> >>> sessions is logged out, the related disks would be removed, which would
> >>> cause the whole system halt.
> >>>
> >>> So we need record session's start up mode in kernel and check this
> >>> mode before logout this session.
> >>>
> >>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> >>> ---
> >>>    drivers/infiniband/ulp/iser/iscsi_iser.c | 1 +
> >>>    drivers/scsi/be2iscsi/be_iscsi.c         | 1 +
> >>>    drivers/scsi/bnx2i/bnx2i_iscsi.c         | 1 +
> >>>    drivers/scsi/cxgbi/libcxgbi.c            | 1 +
> >>>    drivers/scsi/iscsi_tcp.c                 | 1 +
> >>>    drivers/scsi/libiscsi.c                  | 5 +++++
> >>>    drivers/scsi/qedi/qedi_iscsi.c           | 1 +
> >>>    drivers/scsi/qla4xxx/ql4_os.c            | 1 +
> >>>    drivers/scsi/scsi_transport_iscsi.c      | 4 ++++
> >>>    include/scsi/iscsi_if.h                  | 1 +
> >>>    include/scsi/libiscsi.h                  | 1 +
> >>>    11 files changed, 18 insertions(+)
> >>>
> >>> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
> >>> index 620ae5b2d80d..778c023673ea 100644
> >>> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> >>> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> >>> @@ -947,6 +947,7 @@ static umode_t iser_attr_is_visible(int param_type, int param)
> >>>            case ISCSI_PARAM_IFACE_NAME:
> >>>            case ISCSI_PARAM_INITIATOR_NAME:
> >>>            case ISCSI_PARAM_DISCOVERY_SESS:
> >>> +        case ISCSI_PARAM_NODE_STARTUP:
> >>>                return S_IRUGO;
> >>>            default:
> >>>                return 0;
> >>> diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
> >>> index 8aeaddc93b16..a21a4d9ab8b8 100644
> >>> --- a/drivers/scsi/be2iscsi/be_iscsi.c
> >>> +++ b/drivers/scsi/be2iscsi/be_iscsi.c
> >>> @@ -1401,6 +1401,7 @@ umode_t beiscsi_attr_is_visible(int param_type, int param)
> >>>            case ISCSI_PARAM_LU_RESET_TMO:
> >>>            case ISCSI_PARAM_IFACE_NAME:
> >>>            case ISCSI_PARAM_INITIATOR_NAME:
> >>> +        case ISCSI_PARAM_NODE_STARTUP:
> >>>                return S_IRUGO;
> >>>            default:
> >>>                return 0;
> >>> diff --git a/drivers/scsi/bnx2i/bnx2i_iscsi.c b/drivers/scsi/bnx2i/bnx2i_iscsi.c
> >>> index a3c800e04a2e..d1fb06d8a92e 100644
> >>> --- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
> >>> +++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
> >>> @@ -2237,6 +2237,7 @@ static umode_t bnx2i_attr_is_visible(int param_type, int param)
> >>>            case ISCSI_PARAM_BOOT_ROOT:
> >>>            case ISCSI_PARAM_BOOT_NIC:
> >>>            case ISCSI_PARAM_BOOT_TARGET:
> >>> +        case ISCSI_PARAM_NODE_STARTUP:
> >>>                return S_IRUGO;
> >>>            default:
> >>>                return 0;
> >>> diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
> >>> index af281e271f88..111b2ac78964 100644
> >>> --- a/drivers/scsi/cxgbi/libcxgbi.c
> >>> +++ b/drivers/scsi/cxgbi/libcxgbi.c
> >>> @@ -3063,6 +3063,7 @@ umode_t cxgbi_attr_is_visible(int param_type, int param)
> >>>            case ISCSI_PARAM_TGT_RESET_TMO:
> >>>            case ISCSI_PARAM_IFACE_NAME:
> >>>            case ISCSI_PARAM_INITIATOR_NAME:
> >>> +        case ISCSI_PARAM_NODE_STARTUP:
> >>>                return S_IRUGO;
> >>>            default:
> >>>                return 0;
> >>> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> >>> index 5fb1f364e815..47a73fb3e4b0 100644
> >>> --- a/drivers/scsi/iscsi_tcp.c
> >>> +++ b/drivers/scsi/iscsi_tcp.c
> >>> @@ -1036,6 +1036,7 @@ static umode_t iscsi_sw_tcp_attr_is_visible(int param_type, int param)
> >>>            case ISCSI_PARAM_TGT_RESET_TMO:
> >>>            case ISCSI_PARAM_IFACE_NAME:
> >>>            case ISCSI_PARAM_INITIATOR_NAME:
> >>> +        case ISCSI_PARAM_NODE_STARTUP:
> >>>                return S_IRUGO;
> >>>            default:
> >>>                return 0;
> >>> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
> >>> index d95f4bcdeb2e..1f2b0a9a029e 100644
> >>> --- a/drivers/scsi/libiscsi.c
> >>> +++ b/drivers/scsi/libiscsi.c
> >>> @@ -3576,6 +3576,8 @@ int iscsi_set_param(struct iscsi_cls_conn *cls_conn,
> >>>            break;
> >>>        case ISCSI_PARAM_LOCAL_IPADDR:
> >>>            return iscsi_switch_str_param(&conn->local_ipaddr, buf);
> >>> +    case ISCSI_PARAM_NODE_STARTUP:
> >>> +        return iscsi_switch_str_param(&session->node_startup, buf);
> >>>        default:
> >>>            return -ENOSYS;
> >>>        }
> >>> @@ -3712,6 +3714,9 @@ int iscsi_session_get_param(struct iscsi_cls_session *cls_session,
> >>>            else
> >>>                len = sysfs_emit(buf, "\n");
> >>>            break;
> >>> +    case ISCSI_PARAM_NODE_STARTUP:
> >>> +        len = sysfs_emit(buf, "%s\n", session->node_startup);
> >>> +        break;
> >>>        default:
> >>>            return -ENOSYS;
> >>>        }
> >>> diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
> >>> index 31ec429104e2..b947a5bca380 100644
> >>> --- a/drivers/scsi/qedi/qedi_iscsi.c
> >>> +++ b/drivers/scsi/qedi/qedi_iscsi.c
> >>> @@ -1437,6 +1437,7 @@ static umode_t qedi_attr_is_visible(int param_type, int param)
> >>>            case ISCSI_PARAM_BOOT_ROOT:
> >>>            case ISCSI_PARAM_BOOT_NIC:
> >>>            case ISCSI_PARAM_BOOT_TARGET:
> >>> +        case ISCSI_PARAM_NODE_STARTUP:
> >>>                return 0444;
> >>>            default:
> >>>                return 0;
> >>> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> >>> index 9e849f6b0d0f..1cb7c6dbe9d3 100644
> >>> --- a/drivers/scsi/qla4xxx/ql4_os.c
> >>> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> >>> @@ -468,6 +468,7 @@ static umode_t qla4_attr_is_visible(int param_type, int param)
> >>>            case ISCSI_PARAM_DISCOVERY_PARENT_IDX:
> >>>            case ISCSI_PARAM_DISCOVERY_PARENT_TYPE:
> >>>            case ISCSI_PARAM_LOCAL_IPADDR:
> >>> +        case ISCSI_PARAM_NODE_STARTUP:
> >>>                return S_IRUGO;
> >>>            default:
> >>>                return 0;
> >>> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
> >>> index c3fe5ecfee59..39c14d2a8aad 100644
> >>> --- a/drivers/scsi/scsi_transport_iscsi.c
> >>> +++ b/drivers/scsi/scsi_transport_iscsi.c
> >>> @@ -4367,6 +4367,7 @@ iscsi_session_attr(tsid, ISCSI_PARAM_TSID, 0);
> >>>    iscsi_session_attr(def_taskmgmt_tmo, ISCSI_PARAM_DEF_TASKMGMT_TMO, 0);
> >>>    iscsi_session_attr(discovery_parent_idx, ISCSI_PARAM_DISCOVERY_PARENT_IDX, 0);
> >>>    iscsi_session_attr(discovery_parent_type, ISCSI_PARAM_DISCOVERY_PARENT_TYPE, 0);
> >>> +iscsi_session_attr(node_startup, ISCSI_PARAM_NODE_STARTUP, 0);
> >>>      static ssize_t
> >>>    show_priv_session_state(struct device *dev, struct device_attribute *attr,
> >>> @@ -4488,6 +4489,7 @@ static struct attribute *iscsi_session_attrs[] = {
> >>>        &dev_attr_sess_def_taskmgmt_tmo.attr,
> >>>        &dev_attr_sess_discovery_parent_idx.attr,
> >>>        &dev_attr_sess_discovery_parent_type.attr,
> >>> +    &dev_attr_sess_node_startup.attr,
> >>>        NULL,
> >>>    };
> >>>    @@ -4587,6 +4589,8 @@ static umode_t iscsi_session_attr_is_visible(struct kobject *kobj,
> >>>            return S_IRUGO;
> >>>        else if (attr == &dev_attr_priv_sess_target_id.attr)
> >>>            return S_IRUGO;
> >>> +    else if (attr == &dev_attr_sess_node_startup.attr)
> >>> +        param = ISCSI_PARAM_NODE_STARTUP;
> >>>        else {
> >>>            WARN_ONCE(1, "Invalid session attr");
> >>>            return 0;
> >>> diff --git a/include/scsi/iscsi_if.h b/include/scsi/iscsi_if.h
> >>> index 5225a23f2d0e..e46e69c1fd02 100644
> >>> --- a/include/scsi/iscsi_if.h
> >>> +++ b/include/scsi/iscsi_if.h
> >>> @@ -610,6 +610,7 @@ enum iscsi_param {
> >>>        ISCSI_PARAM_DISCOVERY_PARENT_IDX,
> >>>        ISCSI_PARAM_DISCOVERY_PARENT_TYPE,
> >>>        ISCSI_PARAM_LOCAL_IPADDR,
> >>> +    ISCSI_PARAM_NODE_STARTUP,
> >>>        /* must always be last */
> >>>        ISCSI_PARAM_MAX,
> >>>    };
> >>> diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
> >>> index 654cc3918c94..af4ccdcc1140 100644
> >>> --- a/include/scsi/libiscsi.h
> >>> +++ b/include/scsi/libiscsi.h
> >>> @@ -327,6 +327,7 @@ struct iscsi_session {
> >>>        char            *boot_target;
> >>>        char            *portal_type;
> >>>        char            *discovery_parent_type;
> >>> +    char            *node_startup;
> >>>        uint16_t        discovery_parent_idx;
> >>>        uint16_t        def_taskmgmt_tmo;
> >>>        uint16_t        tsid;
> >>
> >> The iscsiadm/iscsid tools refuse to logout of an ONBOOT session.
> >>
> >
> > Sorry I did not highlight the key points. The root reason we need to record
> > node_startup mode in kernel is userspace's node_startup mode is unreliable in
> > some scenarios:
> >
> > 1. iscsi node and session is created in initrd, the configure files of these
> >     nodes would be lost after we switch to rootfs
>
> That is not my experience. When I boot from iscsi root, after the system
> is running, if I tell the iscsiadm to logout of the root iscsi target it
> refuses. I will test again to verify.
>
> > 2. someone do iscsiadm -m discovery but did not specify the operation mode,
> >     the iscsi node's node_startup would be updated to which specified in iscsid.conf
>
> The default on iscsiadm discovery mode is to replace the info on a
> discovered target, but there are other modes. And they don't effect the
> current (root) session.
>
> > 3. someone do iscsiadm -m node -o update to update nodes' configure
>
> Again, does not effect the currently-running session, and can be
> considered shooting oneself in the foot.
>
> >
> > What's more, it seems "iscsiadm/iscsid" only refuse to logout of an ONBOOT
> > session when logout is specificed by "--logoutall". We still can logout an
> > ONBOOT session with "iscsiadm -m node -u comamnd".
>
> Again, I don't believe that's correct. I will test it.
>
> >
> > Based on these analysis, I think we should record the node_startup mode in kernel
> > and check in userspace to avoid logout ONBOOT sessions.
>
I cloned the source code from github and built to test.
Here is my brief test steps:

1. discovery an iSCSI node and login, the default startup
   mode is manual
2. using iscsiadm -m node -o update command to update
   the startup mode to onboot(it did not refused)
3. logout the session with iscsiadm -m node -u
   the logout succeed too.
