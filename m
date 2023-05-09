Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A765E6FBE39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjEIEdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIEdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:33:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438E05277;
        Mon,  8 May 2023 21:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683606782; x=1715142782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D+tdjKHbVSB87BfZn+C52EAsogyovLQG3XPKeR6kMiQ=;
  b=RsAdzfiXkL6XZPbd270bT6sjPvV7ppfRMvwzYwYfXK3sSB6uj2pG1Myb
   vUTKvmjszR38Z1CB0xANBYMFVCJEIOFhrsHW67CNwoqnOhem3jKEpaAeu
   xSQed9u01ruXaxGd2pnpTLoqakojFFvGpCJP9Ypt3bJGTfOFNNnwmhoXo
   kj3J9sBrEWHj9rt7qu4ZmQuQt5kTP9GHYVVTsNqPyaZbyZ96Hr0fy9xVX
   JlmphJiW58ZV1FWhWkkHwkgMumg65APNz59/65nTksCV0KC5SCLqFTYPA
   j94EqEfZQmuiuVqWEvhxvMooE72MnKiOHYzjWhKQy8bJfj6xJogZD1huH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="330167605"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="330167605"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 21:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="763668702"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="763668702"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 May 2023 21:32:57 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwF20-0001hA-2P;
        Tue, 09 May 2023 04:32:56 +0000
Date:   Tue, 9 May 2023 12:32:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "Nicolas F . R . A . Prado" <nfraprado@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2] media: mediatek: vcodec: support stateless hevc
 decoder
Message-ID: <202305091200.B2bZpLsG-lkp@intel.com>
References: <20230428082329.28606-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428082329.28606-1-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master v6.4-rc1 next-20230509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunfei-Dong/media-mediatek-vcodec-support-stateless-hevc-decoder/20230428-162427
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230428082329.28606-1-yunfei.dong%40mediatek.com
patch subject: [PATCH v2] media: mediatek: vcodec: support stateless hevc decoder
config: parisc-buildonly-randconfig-r001-20230508 (https://download.01.org/0day-ci/archive/20230509/202305091200.B2bZpLsG-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/193b8e8eece4506c90eac97b973ef059aaf5c0e1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yunfei-Dong/media-mediatek-vcodec-support-stateless-hevc-decoder/20230428-162427
        git checkout 193b8e8eece4506c90eac97b973ef059aaf5c0e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/media/platform/mediatek/vcodec/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305091200.B2bZpLsG-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c: In function 'vdec_hevc_fill_dpb_info':
>> drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c:412:24: warning: ordered comparison of pointer with integer zero [-Wextra]
     412 |                 if (vb < 0) {
         |                        ^
   drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c: In function 'vdec_hevc_copy_decode_params':
>> drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c:587:63: error: 'const struct v4l2_ctrl_hevc_decode_params' has no member named 'num_delta_pocs_of_ref_rps_idx'
     587 |         dst_params->num_delta_pocs_of_ref_rps_idx = src_params->num_delta_pocs_of_ref_rps_idx;
         |                                                               ^~
   drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c: In function 'vdec_hevc_slice_fill_decode_parameters':
   drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c:630:27: error: 'const struct v4l2_ctrl_hevc_decode_params' has no member named 'num_delta_pocs_of_ref_rps_idx'
     630 |                 dec_params->num_delta_pocs_of_ref_rps_idx;
         |                           ^~


vim +587 drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c

   395	
   396	static void vdec_hevc_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
   397					    struct slice_api_hevc_decode_param *decode_params,
   398					    struct mtk_hevc_dpb_info *hevc_dpb_info)
   399	{
   400		const struct slice_hevc_dpb_entry *dpb;
   401		struct vb2_queue *vq;
   402		struct vb2_buffer *vb;
   403		int index;
   404	
   405		vq = v4l2_m2m_get_vq(ctx->m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
   406		for (index = 0; index < V4L2_HEVC_DPB_ENTRIES_NUM_MAX; index++) {
   407			dpb = &decode_params->dpb[index];
   408			if (index >= decode_params->num_active_dpb_entries)
   409				continue;
   410	
   411			vb = vb2_find_buffer(vq, dpb->timestamp);
 > 412			if (vb < 0) {
   413				dev_err(&ctx->dev->plat_dev->dev,
   414					"Reference invalid: dpb_index(%d) timestamp(%lld)",
   415					index, dpb->timestamp);
   416				continue;
   417			}
   418	
   419			hevc_dpb_info[index].field = dpb->field_pic;
   420	
   421			hevc_dpb_info[index].y_dma_addr = vb2_dma_contig_plane_dma_addr(vb, 0);
   422			if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2)
   423				hevc_dpb_info[index].c_dma_addr = vb2_dma_contig_plane_dma_addr(vb, 1);
   424			else
   425				hevc_dpb_info[index].c_dma_addr =
   426					hevc_dpb_info[index].y_dma_addr + ctx->picinfo.fb_sz[0];
   427		}
   428	}
   429	
   430	static void vdec_hevc_copy_sps_params(struct mtk_hevc_sps_param *dst_param,
   431					      const struct v4l2_ctrl_hevc_sps *src_param)
   432	{
   433		GET_HEVC_VDEC_PARAM(video_parameter_set_id);
   434		GET_HEVC_VDEC_PARAM(seq_parameter_set_id);
   435		GET_HEVC_VDEC_PARAM(pic_width_in_luma_samples);
   436		GET_HEVC_VDEC_PARAM(pic_height_in_luma_samples);
   437		GET_HEVC_VDEC_PARAM(bit_depth_luma_minus8);
   438		GET_HEVC_VDEC_PARAM(bit_depth_chroma_minus8);
   439		GET_HEVC_VDEC_PARAM(log2_max_pic_order_cnt_lsb_minus4);
   440		GET_HEVC_VDEC_PARAM(sps_max_dec_pic_buffering_minus1);
   441		GET_HEVC_VDEC_PARAM(sps_max_num_reorder_pics);
   442		GET_HEVC_VDEC_PARAM(sps_max_latency_increase_plus1);
   443		GET_HEVC_VDEC_PARAM(log2_min_luma_coding_block_size_minus3);
   444		GET_HEVC_VDEC_PARAM(log2_diff_max_min_luma_coding_block_size);
   445		GET_HEVC_VDEC_PARAM(log2_min_luma_transform_block_size_minus2);
   446		GET_HEVC_VDEC_PARAM(log2_diff_max_min_luma_transform_block_size);
   447		GET_HEVC_VDEC_PARAM(max_transform_hierarchy_depth_inter);
   448		GET_HEVC_VDEC_PARAM(max_transform_hierarchy_depth_intra);
   449		GET_HEVC_VDEC_PARAM(pcm_sample_bit_depth_luma_minus1);
   450		GET_HEVC_VDEC_PARAM(pcm_sample_bit_depth_chroma_minus1);
   451		GET_HEVC_VDEC_PARAM(log2_min_pcm_luma_coding_block_size_minus3);
   452		GET_HEVC_VDEC_PARAM(log2_diff_max_min_pcm_luma_coding_block_size);
   453		GET_HEVC_VDEC_PARAM(num_short_term_ref_pic_sets);
   454		GET_HEVC_VDEC_PARAM(num_long_term_ref_pics_sps);
   455		GET_HEVC_VDEC_PARAM(chroma_format_idc);
   456		GET_HEVC_VDEC_PARAM(sps_max_sub_layers_minus1);
   457	
   458		GET_HEVC_VDEC_FLAG(separate_colour_plane,
   459				   V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE);
   460		GET_HEVC_VDEC_FLAG(scaling_list_enabled,
   461				   V4L2_HEVC_SPS_FLAG_SCALING_LIST_ENABLED);
   462		GET_HEVC_VDEC_FLAG(amp_enabled,
   463				   V4L2_HEVC_SPS_FLAG_AMP_ENABLED);
   464		GET_HEVC_VDEC_FLAG(sample_adaptive_offset,
   465				   V4L2_HEVC_SPS_FLAG_SAMPLE_ADAPTIVE_OFFSET);
   466		GET_HEVC_VDEC_FLAG(pcm_enabled,
   467				   V4L2_HEVC_SPS_FLAG_PCM_ENABLED);
   468		GET_HEVC_VDEC_FLAG(pcm_loop_filter_disabled,
   469				   V4L2_HEVC_SPS_FLAG_PCM_LOOP_FILTER_DISABLED);
   470		GET_HEVC_VDEC_FLAG(long_term_ref_pics_enabled,
   471				   V4L2_HEVC_SPS_FLAG_LONG_TERM_REF_PICS_PRESENT);
   472		GET_HEVC_VDEC_FLAG(sps_temporal_mvp_enabled,
   473				   V4L2_HEVC_SPS_FLAG_SPS_TEMPORAL_MVP_ENABLED);
   474		GET_HEVC_VDEC_FLAG(strong_intra_smoothing_enabled,
   475				   V4L2_HEVC_SPS_FLAG_STRONG_INTRA_SMOOTHING_ENABLED);
   476	}
   477	
   478	static void vdec_hevc_copy_pps_params(struct mtk_hevc_pps_param *dst_param,
   479					      const struct v4l2_ctrl_hevc_pps *src_param)
   480	{
   481		int i;
   482	
   483		GET_HEVC_VDEC_PARAM(pic_parameter_set_id);
   484		GET_HEVC_VDEC_PARAM(num_extra_slice_header_bits);
   485		GET_HEVC_VDEC_PARAM(num_ref_idx_l0_default_active_minus1);
   486		GET_HEVC_VDEC_PARAM(num_ref_idx_l1_default_active_minus1);
   487		GET_HEVC_VDEC_PARAM(init_qp_minus26);
   488		GET_HEVC_VDEC_PARAM(diff_cu_qp_delta_depth);
   489		GET_HEVC_VDEC_PARAM(pps_cb_qp_offset);
   490		GET_HEVC_VDEC_PARAM(pps_cr_qp_offset);
   491		GET_HEVC_VDEC_PARAM(num_tile_columns_minus1);
   492		GET_HEVC_VDEC_PARAM(num_tile_rows_minus1);
   493		GET_HEVC_VDEC_PARAM(init_qp_minus26);
   494		GET_HEVC_VDEC_PARAM(diff_cu_qp_delta_depth);
   495		GET_HEVC_VDEC_PARAM(pic_parameter_set_id);
   496		GET_HEVC_VDEC_PARAM(num_extra_slice_header_bits);
   497		GET_HEVC_VDEC_PARAM(num_ref_idx_l0_default_active_minus1);
   498		GET_HEVC_VDEC_PARAM(num_ref_idx_l1_default_active_minus1);
   499		GET_HEVC_VDEC_PARAM(pps_beta_offset_div2);
   500		GET_HEVC_VDEC_PARAM(pps_tc_offset_div2);
   501		GET_HEVC_VDEC_PARAM(log2_parallel_merge_level_minus2);
   502	
   503		for (i = 0; i < 20; i++)
   504			dst_param->column_width_minus1[i] = src_param->column_width_minus1[i];
   505		for (i = 0; i < 22; i++)
   506			dst_param->row_height_minus1[i] = src_param->row_height_minus1[i];
   507	
   508		GET_HEVC_VDEC_FLAG(dependent_slice_segment_enabled,
   509				   V4L2_HEVC_PPS_FLAG_DEPENDENT_SLICE_SEGMENT_ENABLED);
   510		GET_HEVC_VDEC_FLAG(output_flag_present,
   511				   V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT);
   512		GET_HEVC_VDEC_FLAG(sign_data_hiding_enabled,
   513				   V4L2_HEVC_PPS_FLAG_SIGN_DATA_HIDING_ENABLED);
   514		GET_HEVC_VDEC_FLAG(cabac_init_present,
   515				   V4L2_HEVC_PPS_FLAG_CABAC_INIT_PRESENT);
   516		GET_HEVC_VDEC_FLAG(constrained_intra_pred,
   517				   V4L2_HEVC_PPS_FLAG_CONSTRAINED_INTRA_PRED);
   518		GET_HEVC_VDEC_FLAG(transform_skip_enabled,
   519				   V4L2_HEVC_PPS_FLAG_TRANSFORM_SKIP_ENABLED);
   520		GET_HEVC_VDEC_FLAG(cu_qp_delta_enabled,
   521				   V4L2_HEVC_PPS_FLAG_CU_QP_DELTA_ENABLED);
   522		GET_HEVC_VDEC_FLAG(pps_slice_chroma_qp_offsets_present,
   523				   V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT);
   524		GET_HEVC_VDEC_FLAG(weighted_pred,
   525				   V4L2_HEVC_PPS_FLAG_WEIGHTED_PRED);
   526		GET_HEVC_VDEC_FLAG(weighted_bipred,
   527				   V4L2_HEVC_PPS_FLAG_WEIGHTED_BIPRED);
   528		GET_HEVC_VDEC_FLAG(transquant_bypass_enabled,
   529				   V4L2_HEVC_PPS_FLAG_TRANSQUANT_BYPASS_ENABLED);
   530		GET_HEVC_VDEC_FLAG(pps_flag_tiles_enabled,
   531				   V4L2_HEVC_PPS_FLAG_TILES_ENABLED);
   532		GET_HEVC_VDEC_FLAG(entropy_coding_sync_enabled,
   533				   V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED);
   534		GET_HEVC_VDEC_FLAG(loop_filter_across_tiles_enabled,
   535				   V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED);
   536		GET_HEVC_VDEC_FLAG(pps_loop_filter_across_slices_enabled,
   537				   V4L2_HEVC_PPS_FLAG_PPS_LOOP_FILTER_ACROSS_SLICES_ENABLED);
   538		GET_HEVC_VDEC_FLAG(deblocking_filter_override_enabled,
   539				   V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_OVERRIDE_ENABLED);
   540		GET_HEVC_VDEC_FLAG(pps_disable_deflocking_filter,
   541				   V4L2_HEVC_PPS_FLAG_PPS_DISABLE_DEBLOCKING_FILTER);
   542		GET_HEVC_VDEC_FLAG(lists_modification_present,
   543				   V4L2_HEVC_PPS_FLAG_LISTS_MODIFICATION_PRESENT);
   544		GET_HEVC_VDEC_FLAG(slice_segment_header_extersion_present,
   545				   V4L2_HEVC_PPS_FLAG_SLICE_SEGMENT_HEADER_EXTENSION_PRESENT);
   546		GET_HEVC_VDEC_FLAG(deblocking_filter_control_present,
   547				   V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT);
   548		GET_HEVC_VDEC_FLAG(uniform_spacing,
   549				   V4L2_HEVC_PPS_FLAG_UNIFORM_SPACING);
   550	}
   551	
   552	static void vdec_hevc_copy_scaling_matrix(struct slice_api_hevc_scaling_matrix *dst_matrix,
   553						  const struct v4l2_ctrl_hevc_scaling_matrix *src_matrix)
   554	{
   555		memcpy(dst_matrix, src_matrix, sizeof(*src_matrix));
   556	}
   557	
   558	static void
   559	vdec_hevc_copy_decode_params(struct slice_api_hevc_decode_param *dst_params,
   560				     const struct v4l2_ctrl_hevc_decode_params *src_params,
   561				     const struct v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX])
   562	{
   563		struct slice_hevc_dpb_entry *dst_entry;
   564		const struct v4l2_hevc_dpb_entry *src_entry;
   565		int i;
   566	
   567		for (i = 0; i < ARRAY_SIZE(dst_params->dpb); i++) {
   568			dst_entry = &dst_params->dpb[i];
   569			src_entry = &dpb[i];
   570	
   571			dst_entry->timestamp = src_entry->timestamp;
   572			dst_entry->flags = src_entry->flags;
   573			dst_entry->field_pic = src_entry->field_pic;
   574			dst_entry->pic_order_cnt_val = src_entry->pic_order_cnt_val;
   575	
   576			dst_params->poc_st_curr_before[i] = src_params->poc_st_curr_before[i];
   577			dst_params->poc_st_curr_after[i] = src_params->poc_st_curr_after[i];
   578			dst_params->poc_lt_curr[i] = src_params->poc_lt_curr[i];
   579		}
   580	
   581		dst_params->pic_order_cnt_val = src_params->pic_order_cnt_val;
   582		dst_params->short_term_ref_pic_set_size = src_params->short_term_ref_pic_set_size;
   583		dst_params->long_term_ref_pic_set_size = src_params->long_term_ref_pic_set_size;
   584		dst_params->num_active_dpb_entries = src_params->num_active_dpb_entries;
   585		dst_params->num_poc_st_curr_before = src_params->num_poc_st_curr_before;
   586		dst_params->num_poc_st_curr_after = src_params->num_poc_st_curr_after;
 > 587		dst_params->num_delta_pocs_of_ref_rps_idx = src_params->num_delta_pocs_of_ref_rps_idx;
   588		dst_params->num_poc_lt_curr = src_params->num_poc_lt_curr;
   589		dst_params->flags = src_params->flags;
   590	}
   591	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
