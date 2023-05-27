Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B97471328E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 06:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjE0Ebt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 27 May 2023 00:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE0Ebq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 00:31:46 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C59F3;
        Fri, 26 May 2023 21:31:43 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 7A355AEDF7;
        Sat, 27 May 2023 04:31:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 1C27920024;
        Sat, 27 May 2023 04:31:39 +0000 (UTC)
Message-ID: <75851e1185821084c0a1b7e5aaf60e9f38e0f792.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: Check for 0-length and 1-element arrays
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Fri, 26 May 2023 21:31:39 -0700
In-Reply-To: <20230527020929.give.261-kees@kernel.org>
References: <20230527020929.give.261-kees@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1C27920024
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 7xs8qoys85rfj8cia6q67yri4533kui7
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19DFYopygFzH4DcLfvlIBhSms69M9ZZszQ=
X-HE-Tag: 1685161899-625514
X-HE-Meta: U2FsdGVkX1+4Ti+HK7nThf7d4Bb7xBvwyl6bR/qrsQ22OiWD5Xje4I4HWHFlr+7z88ShhcyvBR1w01yeN+oFFQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-05-26 at 19:09 -0700, Kees Cook wrote:
> Fake flexible arrays have been deprecated since last millennium. Proper
> C99 flexible arrays must be used throughout the kernel so
> CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
> bounds checking.

Hi again.


> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7430,6 +7430,21 @@ sub process {
>  			}
>  		}
>  
> +# check for array definition/declarations that should use flexible arrays instead
> +		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
> +		    $prevline =~ /^\+\s*(?:\}|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {

Ahh, now I see why you want to use (?:\}|$Type) to find
struct arrays defined as the last object in another struct.

e.g.: (from drivers/infiniband/hw/mlx5/odp.c)

struct prefetch_mr_work {
	struct work_struct work;
	u32 pf_flags;
	u32 num_sge;
	struct {
		u64 io_virt;
		struct mlx5_ib_mr *mr;
		size_t length;
	} frags[];
};

grepping for some existing variants, perhaps the $sline test should
be extended to something like:

		if ($sline =~ /^[\+ ]\s*}\s*(?:__packed|__attribute__\s*$balanced_parens)?\s*;\s*$/ &&

Dunno, the __packed/__attribute__ uses aren't particularly common.
There are ~1000 uses kernel wide with flexible arrays and only
about 100 with 0 or 1 that could be converted.

like from drivers/net/hyperv/hyperv_net.h:

struct nvsp_6_pd_batch_msg {
	struct nvsp_message_header hdr;
	u16 count;
	u16 guest2host:1;
	u16 is_recv:1;
	u16 reserved:14;
	struct nvsp_6_pd_buf pd_buf[0];
} __packed;

My list (probably incomplete), done with a stupid grep:
(and the 0's are more interesting and much less common than the 1's)

$ git grep -A1 -P '\w+\s+\w+[ \t]*\[\s*[01]?\s*\][ \t]*;'| \
  grep -B1 "\-}" | \
  grep -B1 -P "\-}.*(__attribute__|__packed)" | \
  grep -P '\[\s*[01]\s*\]'
drivers/gpu/drm/hyperv/hyperv_drm_proto.c:	struct video_output_situation video_output[1];
drivers/gpu/drm/hyperv/hyperv_drm_proto.c:	struct rect rect[1];
drivers/hid/intel-ish-hid/ishtp-hid.h:	} __packed reports[1];
drivers/net/ethernet/brocade/bna/bfi_enet.h:	u8		rsvd1[1];
drivers/net/ethernet/emulex/benet/be_cmds.h:	u32 data_buffer[1];
drivers/net/ethernet/emulex/benet/be_cmds.h:	u32 data_buffer[1];
drivers/net/hyperv/hyperv_net.h:	struct nvsp_1_receive_buffer_section sections[1];
drivers/net/hyperv/hyperv_net.h:	struct nvsp_6_pd_buf pd_buf[0];
drivers/net/wireless/ath/ath10k/htc.h:	struct ath10k_htc_record trailer[0];
drivers/net/wireless/ath/ath10k/htt.h:	u8 prefetch[0]; /* start of frame, for FW classification engine */
drivers/net/wireless/ath/ath10k/htt.h:	u8 prefetch[0]; /* start of frame, for FW classification engine */
drivers/net/wireless/ath/ath10k/wmi.h:	struct host_memory_chunk items[1];
drivers/net/wireless/ath/ath10k/wmi.h:	u8 tlvs[0];
drivers/net/wireless/ath/ath10k/wmi.h:	struct wmi_channel channel_list[1];
drivers/net/wireless/ath/ath10k/wmi.h:	u8 data[1];
drivers/net/wireless/ath/ath10k/wmi.h:	u8 data[1];
drivers/net/wireless/ath/ath10k/wmi.h:	struct wmi_channel peer_chan_list[1];
drivers/net/wireless/ath/ath11k/htc.h:	struct ath11k_htc_record trailer[0];
drivers/net/wireless/ath/ath6kl/usb.c:	__le32 _pad[1];
drivers/net/wireless/ath/ath6kl/wmi.h:	u8 reserved[1];
drivers/net/wireless/ath/ath6kl/wmi.h:	struct wmi_pmkid pmkid_list[1];
drivers/net/wireless/ath/ath6kl/wmi.h:	u8 reserved[1];
drivers/net/wireless/ath/carl9170/fwcmd.h:	u32	vals[0];
drivers/net/wireless/ath/carl9170/fwcmd.h:	__le32		regs[0];
drivers/net/wireless/ath/wcn36xx/hal.h:	u8 rem_ie_id[1];
drivers/net/wireless/ath/wil6210/fw.h:	u8 data[0]; /* free-form data [data_size], see above */
drivers/net/wireless/ath/wil6210/fw.h:	struct wil_fw_data_dwrite data[0];
drivers/net/wireless/ath/wil6210/wmi.h:	u8 payload[0];
drivers/net/wireless/ath/wil6210/wmi.h:	u8 reserved[1];
drivers/net/wireless/atmel/at76c50x-usb.h:	u8 reserved[1];
drivers/net/wireless/intel/iwlwifi/fw/api/d3.h:	u8 wake_packet[1];
drivers/net/wireless/intel/iwlwifi/fw/api/rx.h:	__le32 reserved[1];
drivers/net/wireless/intel/iwlwifi/pcie/internal.h:	u8 reserved[1];
drivers/net/wireless/intersil/p54/lmac.h:	u8 exclude[1];
drivers/net/wireless/marvell/mwifiex/fw.h:	struct mwifiex_chan_scan_param_set chan_scan_param[1];
drivers/net/wireless/marvell/mwifiex/fw.h:	u8 bitmap[1];
drivers/net/wireless/marvell/mwifiex/fw.h:	struct chan_band_param_set chan_band_param[1];
drivers/net/wireless/marvell/mwifiex/fw.h:	u8 ssid[1];
drivers/net/wireless/marvell/mwifiex/fw.h:	u8 tsf_data[1];
drivers/net/wireless/marvell/mwifiex/fw.h:	u8 value[1];
drivers/net/wireless/marvell/mwifiex/fw.h:	u8    tlv_buffer[1];
drivers/net/wireless/marvell/mwifiex/fw.h:	struct ieee80211_country_ie_triplet triplet[1];
drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h:	u8 rsv[1];
drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h:	u8 rsv[1];
drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h:	u8 pad[1];
drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h:	u8 pad[1];
drivers/net/wireless/mediatek/mt76/mt7996/mcu.h:	u8 __rsv2[1];
drivers/net/wireless/mediatek/mt76/mt7996/mcu.h:	u8 __rsv2[1];
drivers/net/wireless/quantenna/qtnfmac/qlink.h:	u8 rsvd[1];
drivers/net/wireless/quantenna/qtnfmac/qlink.h:	u8 rsvd[1];
drivers/net/wireless/quantenna/qtnfmac/qlink.h:	u8 rsvd[1];
drivers/net/wireless/quantenna/qtnfmac/qlink.h:	u8 rsvd[1];
drivers/net/wireless/realtek/rtw89/coex.c:	u8 val[1];
drivers/net/wireless/ti/wl18xx/acx.h:	u8 padding[1];
drivers/net/wireless/ti/wl18xx/conf.h:	u8 padding[1];
drivers/net/wireless/ti/wlcore/acx.h:	u8 pad[1];
drivers/net/wireless/ti/wlcore/acx.h:	u8 pad[1];
drivers/net/wireless/ti/wlcore/acx.h:	u8 pad[1];
drivers/net/wireless/ti/wlcore/acx.h:	u8 padding[1];
drivers/net/wireless/ti/wlcore/cmd.h:	u8 padding[1];
drivers/nvmem/u-boot-env.c:	uint8_t data[0];
drivers/platform/x86/dell/dcdbas.h:	__u8 command_buffer[1];
drivers/scsi/be2iscsi/be_cmds.h:	struct	mgmt_conn_info	conn_list[1];
drivers/scsi/be2iscsi/be_cmds.h:	u32 if_hndl_list[1];
drivers/scsi/be2iscsi/be_main.h:	u32 dw[1];
drivers/scsi/be2iscsi/be_main.h:	u32 dw[1];
drivers/scsi/ipr.h:	struct ipr_hostrcb_config_element elem[1];
drivers/scsi/ipr.h:	struct ipr_hostrcb64_config_element elem[1];
drivers/scsi/ipr.h:	struct ipr_hostrcb_fabric_desc desc[1];
drivers/scsi/ipr.h:	struct ipr_hostrcb64_fabric_desc desc[1];
drivers/scsi/ipr.h:	struct ipr_sdt_entry entry[1];
drivers/scsi/ipr.h:	struct ipr_software_inq_lid_info lid[1];
drivers/scsi/megaraid/megaraid_sas.h:	struct MR_PD_ADDRESS   addr[1];
drivers/scsi/megaraid/megaraid_sas.h:	struct MR_HOST_DEVICE_LIST_ENTRY	host_device_list[1];
drivers/video/fbdev/hyperv_fb.c:	struct video_output_situation video_output[1];
drivers/video/fbdev/hyperv_fb.c:	struct rect rect[1];
fs/adfs/dir_fplus.h:	char	bigdirname[1];
fs/crypto/fscrypt_private.h:	char encrypted_path[1];
fs/isofs/rock.h:	__u8 flags[1];
fs/ksmbd/smb2pdu.h:	__u8 Chunks[1]; /* array of srv_copychunk */
fs/ksmbd/smb2pdu.h:	char name[1];
fs/ksmbd/smb_common.h:	unsigned char DialectsArray[1];
fs/ksmbd/smb_common.h:	__le16 FileSystemName[1]; /* do not have to save this - get subset? */
fs/ksmbd/smb_common.h:	__le16 VolumeLabel[1];
fs/ntfs/dir.h:	ntfschar name[0];
fs/ntfs/layout.h:/* 42*/	ntfschar file_name[0];			/* File name in Unicode. */
fs/ntfs/layout.h:	le32 sub_authority[1];		/* At least one sub_authority. */
fs/ntfs/layout.h:	ntfschar name[0];	/* The name of the volume in Unicode. */
fs/ntfs/layout.h:	u8 data[0];		/* The file's data contents. */
fs/ntfs/layout.h:	u8 bitmap[0];			/* Array of bits. */
fs/ntfs/layout.h:	u8 reparse_data[0];		/* Meaning depends on reparse_tag. */
fs/reiserfs/reiserfs.h:	__u16 entry_sizes[1];
include/linux/greybus/greybus_protocols.h:	__u8			data[0];
include/linux/greybus/greybus_protocols.h:	__u8			data[0];
include/linux/greybus/greybus_protocols.h:	__u8			data[0];
include/linux/greybus/greybus_protocols.h:	__u8				report[0];
include/linux/greybus/greybus_protocols.h:	__u8				data[0];	/* inbound data */
include/linux/greybus/greybus_protocols.h:	__u8			data[0];/* inbound data */
include/linux/hid.h:	struct hid_class_descriptor desc[1];
include/linux/hyperv.h:	struct vmtransfer_page_range ranges[1];
include/linux/hyperv.h:	struct gpa_range range[1];
include/linux/hyperv.h:	struct gpa_range range[1];
include/linux/hyperv.h:	unsigned char data[1];
include/linux/ieee80211.h:	u8 virtual_map[1];
include/linux/mtd/cfi.h:	struct cfi_intelext_blockinfo BlockTypes[1];
include/linux/mtd/cfi.h:	uint32_t ProtField[1]; /* Not host ordered */
include/linux/mtd/cfi.h:	uint32_t ConfField[1]; /* Not host ordered */
include/linux/ti_wilink_st.h:	u8 data[0];
include/scsi/fc/fc_ms.h:	struct fc_fdmi_port_name	port[1];
include/uapi/linux/bpf.h:	__u64 __opaque[1];
include/uapi/linux/usb/ch9.h:	__le16 wData[1];		/* UTF-16LE encoded */
tools/include/uapi/linux/bpf.h:	__u64 __opaque[1];
tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c:	char x[0];
tools/testing/selftests/kvm/include/x86_64/processor.h:	u8			extended_state_area[0];

> +			if ($1 == '0') {
> +				if (ERROR("ZERO_LENGTH_ARRAY",
> +					  "Use C99 flexible arrays instead of zero-length arrays - see https://github.com/KSPP/linux/issues/78\n" . $hereprev) &&

Instead of github links, how about using:
https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays


Why not combine both of these into a single ERROR?
What's the value in separate types?

			if (ERROR("FLEXIBLE_ARRAY",
				  "Use C99 flexible arrays - see: https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays\n" . $hereprev) &&
				  $fix && $1 == '0') {
				etc...
				

> +				    $fix) {
> +					$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
> +				}
> +			} else {
> +				ERROR("ONE_ELEMENT_ARRAY",
> +				      "Use C99 flexible arrays instead of one-element arrays - see https://github.com/KSPP/linux/issues/79\n" . $hereprev);
> +			}
> +		}
> +
>  # nested likely/unlikely calls
>  		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
>  			WARN("LIKELY_MISUSE",

