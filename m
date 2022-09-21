Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C593F5BF5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 07:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIUFcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 01:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIUFcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 01:32:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F38F7269B;
        Tue, 20 Sep 2022 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663738328; x=1695274328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L7r9JhoLAVWcL9IVhZgpSIrSK1y0jQjeL3Vcqf/VTeE=;
  b=XnjqfM1ZqS1gUyZ6nkbX/Ml1O5OyfwgP7ym9HvLv6n7Qq6eZEZEX6eEM
   CFdj0p8EU3Ly1KJfiMzRh7QdbTRIjwBAB1Alcr0yCkCX+jsn9rjNJkdZ7
   WkGy84XYcSmyPwiufQubn9RkJyaW0y7jtUwaRjSl0K7x/NmO1hKL2Y6mn
   C/X9MbTF+N2PGjAF9J69Byaa7CRH9MWmafzGWMiZ+ph1auC/0rmDfptv4
   cFsWh3Ql2c0GOz8HyUJXFq47SM2QyDpSzqvVr1Xu4XwlSAHHZPp9rnlRs
   YEQz1PFAmdJjkotAHeWF3g1cEl6Mr/Hvn+/KoXdRWdpp862QOqmq+2n0C
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="299891839"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="299891839"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 22:32:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="708296404"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Sep 2022 22:32:05 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oasL6-0003Gr-2Q;
        Wed, 21 Sep 2022 05:32:04 +0000
Date:   Wed, 21 Sep 2022 13:31:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yihao Han <hanyihao@vivo.com>, Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Yihao Han <hanyihao@vivo.com>
Subject: Re: [PATCH] scsi: qla2xxx: fix excluded_middle.cocci warnings
Message-ID: <202209211330.Evw4tUuR-lkp@intel.com>
References: <20220920024554.2606-1-hanyihao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920024554.2606-1-hanyihao@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yihao,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jejb-scsi/for-next]
[also build test ERROR on mkp-scsi/for-next linus/master v6.0-rc6 next-20220920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yihao-Han/scsi-qla2xxx-fix-excluded_middle-cocci-warnings/20220920-104643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: x86_64-randconfig-a006-20220919 (https://download.01.org/0day-ci/archive/20220921/202209211330.Evw4tUuR-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/81672bb39d1900d22e851a7cfb0b9a0aa35df8af
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yihao-Han/scsi-qla2xxx-fix-excluded_middle-cocci-warnings/20220920-104643
        git checkout 81672bb39d1900d22e851a7cfb0b9a0aa35df8af
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/scsi/qla2xxx/qla_target.c:1031:65: error: expected ')'
                       (!own || (own->iocb.u.isp24.status_subcode == ELS_PLOGI)) {
                                                                                 ^
   drivers/scsi/qla2xxx/qla_target.c:1030:6: note: to match this '('
                   if (ha->flags.edif_enabled &&
                      ^
>> drivers/scsi/qla2xxx/qla_target.c:1047:2: error: expected statement
           }
           ^
   2 errors generated.


vim +1031 drivers/scsi/qla2xxx/qla_target.c

   961	
   962	void qlt_free_session_done(struct work_struct *work)
   963	{
   964		struct fc_port *sess = container_of(work, struct fc_port,
   965		    free_work);
   966		struct qla_tgt *tgt = sess->tgt;
   967		struct scsi_qla_host *vha = sess->vha;
   968		struct qla_hw_data *ha = vha->hw;
   969		unsigned long flags;
   970		bool logout_started = false;
   971		scsi_qla_host_t *base_vha = pci_get_drvdata(ha->pdev);
   972		struct qlt_plogi_ack_t *own =
   973			sess->plogi_link[QLT_PLOGI_LINK_SAME_WWN];
   974	
   975		ql_dbg(ql_dbg_disc, vha, 0xf084,
   976			"%s: se_sess %p / sess %p from port %8phC loop_id %#04x"
   977			" s_id %02x:%02x:%02x logout %d keep %d els_logo %d\n",
   978			__func__, sess->se_sess, sess, sess->port_name, sess->loop_id,
   979			sess->d_id.b.domain, sess->d_id.b.area, sess->d_id.b.al_pa,
   980			sess->logout_on_delete, sess->keep_nport_handle,
   981			sess->send_els_logo);
   982	
   983		if (!IS_SW_RESV_ADDR(sess->d_id)) {
   984			qla2x00_mark_device_lost(vha, sess, 0);
   985	
   986			if (sess->send_els_logo) {
   987				qlt_port_logo_t logo;
   988	
   989				logo.id = sess->d_id;
   990				logo.cmd_count = 0;
   991				INIT_LIST_HEAD(&logo.list);
   992				if (!own)
   993					qlt_send_first_logo(vha, &logo);
   994				sess->send_els_logo = 0;
   995			}
   996	
   997			if (sess->logout_on_delete && sess->loop_id != FC_NO_LOOP_ID) {
   998				int rc;
   999	
  1000				if (!own ||
  1001				     (own->iocb.u.isp24.status_subcode == ELS_PLOGI)) {
  1002					sess->logout_completed = 0;
  1003					rc = qla2x00_post_async_logout_work(vha, sess,
  1004					    NULL);
  1005					if (rc != QLA_SUCCESS)
  1006						ql_log(ql_log_warn, vha, 0xf085,
  1007						    "Schedule logo failed sess %p rc %d\n",
  1008						    sess, rc);
  1009					else
  1010						logout_started = true;
  1011				} else if (own && (own->iocb.u.isp24.status_subcode ==
  1012					ELS_PRLI) && ha->flags.rida_fmt2) {
  1013					rc = qla2x00_post_async_prlo_work(vha, sess,
  1014					    NULL);
  1015					if (rc != QLA_SUCCESS)
  1016						ql_log(ql_log_warn, vha, 0xf085,
  1017						    "Schedule PRLO failed sess %p rc %d\n",
  1018						    sess, rc);
  1019					else
  1020						logout_started = true;
  1021				}
  1022			} /* if sess->logout_on_delete */
  1023	
  1024			if (sess->nvme_flag & NVME_FLAG_REGISTERED &&
  1025			    !(sess->nvme_flag & NVME_FLAG_DELETING)) {
  1026				sess->nvme_flag |= NVME_FLAG_DELETING;
  1027				qla_nvme_unregister_remote_port(sess);
  1028			}
  1029	
  1030			if (ha->flags.edif_enabled &&
> 1031			    (!own || (own->iocb.u.isp24.status_subcode == ELS_PLOGI)) {
  1032				sess->edif.authok = 0;
  1033				if (!ha->flags.host_shutting_down) {
  1034					ql_dbg(ql_dbg_edif, vha, 0x911e,
  1035					       "%s wwpn %8phC calling qla2x00_release_all_sadb\n",
  1036					       __func__, sess->port_name);
  1037					qla2x00_release_all_sadb(vha, sess);
  1038				} else {
  1039					ql_dbg(ql_dbg_edif, vha, 0x911e,
  1040					       "%s bypassing release_all_sadb\n",
  1041					       __func__);
  1042				}
  1043	
  1044				qla_edif_clear_appdata(vha, sess);
  1045				qla_edif_sess_down(vha, sess);
  1046			}
> 1047		}
  1048	
  1049		/*
  1050		 * Release the target session for FC Nexus from fabric module code.
  1051		 */
  1052		if (sess->se_sess != NULL)
  1053			ha->tgt.tgt_ops->free_session(sess);
  1054	
  1055		if (logout_started) {
  1056			bool traced = false;
  1057			u16 cnt = 0;
  1058	
  1059			while (!READ_ONCE(sess->logout_completed)) {
  1060				if (!traced) {
  1061					ql_dbg(ql_dbg_disc, vha, 0xf086,
  1062						"%s: waiting for sess %p logout\n",
  1063						__func__, sess);
  1064					traced = true;
  1065				}
  1066				msleep(100);
  1067				cnt++;
  1068				/*
  1069				 * Driver timeout is set to 22 Sec, update count value to loop
  1070				 * long enough for log-out to complete before advancing. Otherwise,
  1071				 * straddling logout can interfere with re-login attempt.
  1072				 */
  1073				if (cnt > 230)
  1074					break;
  1075			}
  1076	
  1077			ql_dbg(ql_dbg_disc, vha, 0xf087,
  1078			    "%s: sess %p logout completed\n", __func__, sess);
  1079		}
  1080	
  1081		if (sess->logo_ack_needed) {
  1082			sess->logo_ack_needed = 0;
  1083			qla24xx_async_notify_ack(vha, sess,
  1084				(struct imm_ntfy_from_isp *)sess->iocb, SRB_NACK_LOGO);
  1085		}
  1086	
  1087		spin_lock_irqsave(&vha->work_lock, flags);
  1088		sess->flags &= ~FCF_ASYNC_SENT;
  1089		spin_unlock_irqrestore(&vha->work_lock, flags);
  1090	
  1091		spin_lock_irqsave(&ha->tgt.sess_lock, flags);
  1092		if (sess->se_sess) {
  1093			sess->se_sess = NULL;
  1094			if (tgt && !IS_SW_RESV_ADDR(sess->d_id))
  1095				tgt->sess_count--;
  1096		}
  1097	
  1098		qla2x00_set_fcport_disc_state(sess, DSC_DELETED);
  1099		sess->fw_login_state = DSC_LS_PORT_UNAVAIL;
  1100		sess->deleted = QLA_SESS_DELETED;
  1101	
  1102		if (sess->login_succ && !IS_SW_RESV_ADDR(sess->d_id)) {
  1103			vha->fcport_count--;
  1104			sess->login_succ = 0;
  1105		}
  1106	
  1107		qla2x00_clear_loop_id(sess);
  1108	
  1109		if (sess->conflict) {
  1110			sess->conflict->login_pause = 0;
  1111			sess->conflict = NULL;
  1112			if (!test_bit(UNLOADING, &vha->dpc_flags))
  1113				set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
  1114		}
  1115	
  1116		{
  1117			struct qlt_plogi_ack_t *con =
  1118			    sess->plogi_link[QLT_PLOGI_LINK_CONFLICT];
  1119			struct imm_ntfy_from_isp *iocb;
  1120	
  1121			own = sess->plogi_link[QLT_PLOGI_LINK_SAME_WWN];
  1122	
  1123			if (con) {
  1124				iocb = &con->iocb;
  1125				ql_dbg(ql_dbg_tgt_mgt, vha, 0xf099,
  1126					 "se_sess %p / sess %p port %8phC is gone,"
  1127					 " %s (ref=%d), releasing PLOGI for %8phC (ref=%d)\n",
  1128					 sess->se_sess, sess, sess->port_name,
  1129					 own ? "releasing own PLOGI" : "no own PLOGI pending",
  1130					 own ? own->ref_count : -1,
  1131					 iocb->u.isp24.port_name, con->ref_count);
  1132				qlt_plogi_ack_unref(vha, con);
  1133				sess->plogi_link[QLT_PLOGI_LINK_CONFLICT] = NULL;
  1134			} else {
  1135				ql_dbg(ql_dbg_tgt_mgt, vha, 0xf09a,
  1136				    "se_sess %p / sess %p port %8phC is gone, %s (ref=%d)\n",
  1137				    sess->se_sess, sess, sess->port_name,
  1138				    own ? "releasing own PLOGI" :
  1139				    "no own PLOGI pending",
  1140				    own ? own->ref_count : -1);
  1141			}
  1142	
  1143			if (own) {
  1144				sess->fw_login_state = DSC_LS_PLOGI_PEND;
  1145				qlt_plogi_ack_unref(vha, own);
  1146				sess->plogi_link[QLT_PLOGI_LINK_SAME_WWN] = NULL;
  1147			}
  1148		}
  1149	
  1150		sess->explicit_logout = 0;
  1151		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
  1152		sess->free_pending = 0;
  1153	
  1154		qla2x00_dfs_remove_rport(vha, sess);
  1155	
  1156		ql_dbg(ql_dbg_disc, vha, 0xf001,
  1157		    "Unregistration of sess %p %8phC finished fcp_cnt %d\n",
  1158			sess, sess->port_name, vha->fcport_count);
  1159	
  1160		if (tgt && (tgt->sess_count == 0))
  1161			wake_up_all(&tgt->waitQ);
  1162	
  1163		if (!test_bit(PFLG_DRIVER_REMOVING, &base_vha->pci_flags) &&
  1164		    !(vha->vp_idx && test_bit(VPORT_DELETE, &vha->dpc_flags)) &&
  1165		    (!tgt || !tgt->tgt_stop) && !LOOP_TRANSITION(vha)) {
  1166			switch (vha->host->active_mode) {
  1167			case MODE_INITIATOR:
  1168			case MODE_DUAL:
  1169				set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
  1170				qla2xxx_wake_dpc(vha);
  1171				break;
  1172			case MODE_TARGET:
  1173			default:
  1174				/* no-op */
  1175				break;
  1176			}
  1177		}
  1178	
  1179		if (vha->fcport_count == 0)
  1180			wake_up_all(&vha->fcport_waitQ);
  1181	}
  1182	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
